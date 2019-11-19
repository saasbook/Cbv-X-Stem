class DocumentationsController < ApplicationController
  def index
    @documentations = Documentation.all
  end

  def new
    @documentation = Documentation.new
  end

  def create
      @documentation = Documentation.new(documentation_params)
      
      if @documentation.save
         
         redirect_to documentations_path, notice: "The document #{@documentation.patient} has been uploaded."
         send_notification(@documentation)
      else
         render "new"
      end
  end

  def download_pdf
    @documentation = Documentation.find(params[:id])
    puts @documentation.inspect
    puts @documentation.attachment_url
    puts "DOWNLOADING METHOD"
    send_file("#{Rails.root}/public/" + @documentation.attachment_url, type: "application/pdf", x_sendfile: true)
    # redirect_to documentations_path, notice: "The document #{@documentation.patient} has been downloaded."
  end

  def send_notification(documentation) 
    @first_name, @last_name = documentation.patient.split
    @cur_user = User.where(first_name: @first_name, last_name: @last_name).first
    @current_holder = @cur_user.user_holder
    @current_setting = @current_holder.user_setting
      if @current_setting.email_notification
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

  def destroy
    @documentation = Documentation.find(params[:id])
    @documentation.destroy
    puts "TEST"
    redirect_to documentations_path, notice: "The document #{@documentation.patient} has been deleted."
  end

  private
    def documentation_params
    params.require(:documentation).permit(:patient, :attachment)
  end

end
