class MedicationsController < ApplicationController
  before_action :set_medication, only: [:show, :edit, :update, :destroy]
  authorize_resource
  include UserActivitiesHelper
  include MessagesHelper

  rescue_from CanCan::AccessDenied do |exception|
    redirect_from_cancan_access_denied(user_holder_medications_path(current_user.user_holder), exception.message)
  end




  # GET /medications
  # GET /medications.json
  def index
    @medications = @user_holder.medications
    general_controller_index
  end

  # GET /medications/1
  # GET /medications/1.json
  def show
  end

  # GET /medications/new
  def new
    @medication = @user_holder.medications.build
  end

  # GET /medications/1/edit
  def edit
  end

  # POST /medications
  # POST /medications.json
  def create
    @medication = @user_holder.medications.build(medication_params)
    general_controller_create_with_log_notification(@medication, "medication", user_holder_medications_path(@user_holder))
  end

  # PATCH/PUT /medications/1
  # PATCH/PUT /medications/1.json
  def update
    general_controller_update_with_log_notification(@medication, medication_params, "medication", user_holder_medications_path(@user_holder))
  end

  # DELETE /medications/1
  # DELETE /medications/1.json
  def destroy
    general_controller_delete_with_log(current_user.user_holder, @user_holder, @medication, user_holder_medications_path(@user_holder))
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_medication
      # @medication = @user_holder.medications.find(params[:id])
      @medication = Medication.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def medication_params
      params.require(:medication).permit(:provider, :directions, :days, :description, :user_holder_id, :name)
    end
end
