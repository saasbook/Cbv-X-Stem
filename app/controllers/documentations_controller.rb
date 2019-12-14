class DocumentationsController < ApplicationController
  before_action :set_documentation, only: [:show, :edit, :update, :destroy]
  include UserActivitiesHelper
  include MessagesHelper
  def index
    @documentations = @user_holder.documentations
    general_controller_index
  end

  def new
    @documentation = @user_holder.documentations.build
  end

  def create

      # # @user = User.find_by_email(@user_holder.email)
      # # name = [@user.first_name, @user.last_name].join(" ")
      # puts "Documentation Params"
      # # puts documentation_params

      # # NEED TO GET A WAY TO GET THE APPROPRIATE USER HOLDER based on name input
      # # @cur_user_holder = current_user.user_holder
      # puts "USER HOLDER"
      # puts @user_holder
      # name = [@user_holder.first_name, @user_holder.last_name].join(" ")
      # puts name
      # documentation_params[:uploaded_by] = name
      # puts documentation_params
      # @documentation = @user_holder.documentations.create(documentation_params)
      # # @documentation.patient = name
      # puts @documentation.inspect


      # # # Ensure that only one row for the given patient
      # # Documentation.all.each do |document|
      # #   puts "TESTING2"
      # #   puts @documentation.patient
      # #   puts document.patient
      # #   if document.patient == @documentation.patient
      # #     Documentation.find(document.id).destroy
      # #   end
      # # end

      # if @documentation.save

      #    redirect_to user_holder_documentations_path(@user_holder), notice: "The document #{@documentation.patient} has been uploaded."
      #    send_notification(@documentation)
      # else
      #    render "new"
      #------------------
      @documentation = @user_holder.documentations.build(documentation_params)
      general_controller_create_with_log_notification(@documentation, "documentation", user_holder_documentations_path(@user_holder))
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
    if @documentation.update(documentation_params)

      flash[:notice] = ['Document was successfully Updated.']
      if @user_holder.user_setting.nil?
        @user_holder.user_setting = UserSetting.create(:user_holder_id => @user_holder.user_id)
      end
      send_email_notif("documentation", "updated")
      send_whatsapp_notif("documentation", "updated")

      redirect_to user_holder_documentations_path(@user_holder)
    end
  end

  def information
    @documentation = Documentation.find(params[:id])
    if @documentation.satisfied == true
      render "documentations/satisfied"
    else
      render "documentations/not_satisfied"
    end
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

  #def send_notification(documentation, action)
  #  @first_name, @last_name = documentation.patient.split
  #  @current_setting = @user_holder.user_setting

  #  unless @current_setting.nil?
  #    if @current_setting.email_notif
  #        @cur_user_email = @user_holder.email
  #    end
  #    if @current_setting && @current_setting.email_notification
  #        @cur_user_email = @cur_user.email

  #        @message = Message.new(:sender_name => documentation.patient)
  #        @message.receiver_email = 'cbvxstem@gmail.com'
  #        MessageMailer.document_notification(@message).deliver
  #        if @cur_user_email != ""
  #            @message.sender_email =  @cur_user_email
  #            MessageMailer.document_confirmation(@message).deliver
  #        end
  #    end
  #  end
  #end

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
      params.require(:documentation).permit(:patient, :attachment, :doctype, :documents_name, :documents_info, :documents_status, :documents_explanation, :user_holder_id, :satisfied, :reasoning, :updated_by, :uploaded_by)
    end

end
