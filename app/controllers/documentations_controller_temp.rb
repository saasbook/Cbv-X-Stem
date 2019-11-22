class DocumentationsController < ApplicationController
    def index
      # @user = User.find_by_email(@user_holder.email)
      # puts @user.inspect
      # name = [@user.first_name, @user.last_name].join(" ")
      # puts name
      # @documentations = Documentation.find_by_patient(name)
  
      # puts "DOCUMENTATION CHECK"
      # puts @documentations
      # @documentations.each do |d|
      #   puts d 
      # end
        
      # puts @documentations.nil?
      # if @documentations.nil?
      #   @documentations = []
      # end
  
      #TEMP
  
      @documentations = Documentation.all
  
      # @documentations = Documentation.all
      # puts @documentations.inspect
      #Testing
      # puts @documentations[0].inspect
      @user = User.find_by_email(@user_holder.email)
      if @user.is_doctor?
        render "documentations/index"
      else
        render "documentations/patient_index"
      end
      # puts User.find_by(first_name: @documentations[0].patient)
      # puts "TESTING"
      # puts @user_holder.inspect
      # puts @documentations[0].inspect
    end
  
    def new
      @documentation = Documentation.new
      @user = User.find_by_email(@user_holder.email)
      if @user.is_doctor?
        render "documentations/new"
      else
        render "documentations/patient_new"
      end
    end
  
    def create
        # @user = User.find_by_email(@user_holder.email)
        # name = [@user.first_name, @user.last_name].join(" ")
        puts "Documentation Params"
        puts documentation_params
        @documentation = Documentation.new(documentation_params)
        # @documentation.patient = name
        puts @documentation.inspect
  
  
        # # Ensure that only one row for the given patient
        # Documentation.all.each do |document|
        #   puts "TESTING2"
        #   puts @documentation.patient
        #   puts document.patient
        #   if document.patient == @documentation.patient
        #     Documentation.find(document.id).destroy
        #   end
        # end
  
        if @documentation.save
  
           redirect_to documentations_path, notice: "The document #{@documentation.patient} has been uploaded."
           send_notification(@documentation)
        else
           render "new"
        end
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
      redirect_to documentations_path, notice: "The document #{@documentation.patient} has been updated."
      send_notification(@documentation)
    end
  
  
    def download_pdf
      @documentation = Documentation.find(params[:id])
      puts @documentation.inspect
      puts @documentation.attachment_url
      puts "DOWNLOADING METHOD"
      send_file("#{Rails.root}/public/" + @documentation.attachment_url, type: "application/pdf", x_sendfile: true)
      # redirect_to documentations_path, notice: "The document #{@documentation.patient} has been downloaded."
    end
  
    #TESTING
    def update
      @documentation = Documentation.find(params[:id])
  
    end
  
    def send_notification(documentation)
      @first_name, @last_name = documentation.patient.split
      @current_setting = @user_holder.user_setting
      unless @current_setting.nil?
        if @current_setting.email_notification
            @cur_user_email = @user_holder.email
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
      @documentation = Documentation.find(params[:id])
      @documentation.destroy
      puts "TEST"
      redirect_to documentations_path, notice: "The document #{@documentation.patient} has been deleted."
    end
  
    private
      def documentation_params
        params.require(:documentation).permit(:patient, :attachment, :doctype, :documents_name, :documents_info, :documents_status, :documents_explanation)
      end
  
  end
  