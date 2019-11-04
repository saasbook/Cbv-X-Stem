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

  def destroy
    @documentation = Documentation.find(params[:id])
    @documentation.destroy
    redirect_to documentations_path, notice: "The document #{@documentation.patient} has been deleted."
  end

  private
    def documentation_params
    params.require(:documentation).permit(:patient, :attachement)
  end

end
