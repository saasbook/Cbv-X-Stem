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
      else
         render "new"
      end
  end


  def download_pdf
    @documentation = Documentation.find(params[:id])
    puts @documentation.inspect
    puts @documentation.attachment_url
    puts "DOWNLOADING METHOD"
    send_data("#{Rails.root}/public/" + @documentation.attachment_url, type: "application/pdf", x_sendfile: true)
    # redirect_to documentations_path, notice: "The document #{@documentation.patient} has been downloaded."
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
