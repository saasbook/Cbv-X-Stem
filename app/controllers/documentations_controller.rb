class DocumentationsController < ApplicationController
  before_action :set_documentation, only: [:show, :edit, :update, :destroy]
  include UserActivitiesHelper
  def index
    @documentations = @user_holder.documentations
  end

  def new
    @documentation = @user_holder.documentations.build
  end

  def create
      @documentation = @user_holder.documentations.build(documentation_params)
      respond_to do |format|
        if @documentation.save
          format.html { redirect_to user_holder_documentations_path(@user_holder), notice: 'Document was successfully created.' }
          format.json { render :show, status: :created, location: @documentation }
          log_create_delete_to_user_activities('document', 'create', current_user.user_holder, @user_holder)
          send_notification(@documentation)
        else
          format.html { render :new }
          format.json { render json: @documentation.errors, status: :unprocessable_entity }
        end
      end
  end

  def edit
  end

  def update_landing
    @documentation = Documentation.find(params[:id])
    puts "UPDATE DOCUMENT LANDING"
    puts @documentation.inspect
    render "documentations/patient_update"
  end

  def update
    @documentation = Documentation.find(params[:id])
    @documentation.update(documentation_params)
    redirect_to user_holder_documentations_path(@user_holder), notice: 'Document was successfully Updated.'
    send_notification(@documentation)
  end


  def download_pdf
    #@documentation = @user_holder.documentations.find(params[:id])
    @documentation = Documentation.find(params[:id])
    puts @documentation.inspect
    puts @documentation.attachment_url
    puts "DOWNLOADING METHOD"
    send_file("#{Rails.root}/public/" + @documentation.attachment_url, type: "application/pdf", x_sendfile: true)
    # redirect_to documentations_path, notice: "The document #{@documentation.patient} has been downloaded."
  end

  def send_notification(documentation)
    @first_name, @last_name = documentation.patient.split
    @current_setting = @user_holder.user_setting

    unless @current_setting.nil?
      if @current_setting.email_notification
          @cur_user_email = @user_holder.email
      end
      if @current_setting && @current_setting.email_notification
          @cur_user_email = @cur_user.email

          @message = Message.new(:sender_name => documentation.patient)
          @message.receiver_email = 'cbvxstem@gmail.com'
          MessageMailer.document_notification(@message).deliver
          if @cur_user_email != ""
              @message.sender_email =  @cur_user_email
              MessageMailer.document_confirmation(@message).deliver
          end
      end
    end
  end

  def destroy
    @documentation.destroy
    log_create_delete_to_user_activities('document', 'delete', current_user.user_holder, @user_holder)
    respond_to do |format|
      format.html { redirect_to user_holder_documentations_path(@user_holder), notice: 'Document was successfully destroyed.' }
      format.json { head :no_content }
    end

  end

  private
    def set_documentation
      @documentation = @user_holder.documentations.find(params[:id])
    end

    def documentation_params
      params.require(:documentation).permit(:patient, :attachment, :doctype, :documents_name, :documents_info, :documents_status, :documents_explanation, :user_holder_id)
    end

end
