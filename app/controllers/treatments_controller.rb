class TreatmentsController < ApplicationController
  # before_action :authenticate_user!
  before_action :set_treatment, only: [:show, :edit, :update, :destroy]
  authorize_resource
  include UserActivitiesHelper
  include MessagesHelper

  rescue_from CanCan::AccessDenied do |exception|
    redirect_from_cancan_access_denied(user_holder_treatments_path(current_user.user_holder), exception.message)
  end

  # GET /treatments
  # GET /treatments.json
  def index
    @treatments = @user_holder.treatments
    general_controller_index
  end

  # GET /treatments/1
  # GET /treatments/1.json
  def show
  end

  # GET /treatments/new
  def new
    @treatment = @user_holder.treatments.build
  end

  # GET /treatments/1/edit
  def edit
  end

  # POST /treatments
  # POST /treatments.json
  def create
    @treatment = @user_holder.treatments.build(treatment_params)
    general_controller_create_with_log_notification(@treatment, "treatment", user_holder_treatments_path(@user_holder))
  end

  # PATCH/PUT /treatments/1
  # PATCH/PUT /treatments/1.json
  def update
    general_controller_update_with_log_notification(@treatment, treatment_params, "treatment", user_holder_treatments_path(@user_holder))
  end

  # DELETE /treatments/1
  # DELETE /treatments/1.json
  def destroy
    general_controller_delete_with_log(current_user.user_holder, @user_holder, @treatment, user_holder_treatments_path(@user_holder))
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_treatment
      @treatment = @user_holder.treatments.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def treatment_params
      params.require(:treatment).permit(:provider, :name, :location, :status, :description, :user_holder_id)
    end
end
