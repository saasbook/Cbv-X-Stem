class MedicationsController < ApplicationController
  before_action :set_medication, only: [:show, :edit, :update, :destroy]
  authorize_resource
  include UserActivitiesHelper

  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.json { head :forbidden, content_type: 'text/html' }
      format.html { redirect_to user_holder_medications_path(current_user.user_holder), notice: exception.message }
      format.js   { head :forbidden, content_type: 'text/html' }
    end
  end
  # GET /medications
  # GET /medications.json
  def index
    @medications = @user_holder.medications
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

    respond_to do |format|
      if @medication.save
        format.html { redirect_to user_holder_medications_path(@user_holder), notice: 'Medication was successfully created.' }
        format.json { render :show, status: :created, location: @medication }
        log_create_delete_to_user_activities('medication', 'create', current_user.user_holder, @user_holder)
      else
        format.html { render :new }
        format.json { render json: @medication.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /medications/1
  # PATCH/PUT /medications/1.json
  def update
    respond_to do |format|
      temp_medication = @medication.as_json
      if @medication.update(medication_params)
        format.html { redirect_to user_holder_medications_path(@user_holder), notice: 'Medication was successfully updated.' }
        format.json { render :show, status: :ok, location: @medication }
        log_change_to_user_activities('medication', 'edit', current_user.user_holder, @user_holder, temp_medication, @medication.as_json)
      else
        format.html { render :edit }
        format.json { render json: @medication.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /medications/1
  # DELETE /medications/1.json
  def destroy
    @medication.destroy
    log_create_delete_to_user_activities('medication', 'delete', current_user.user_holder, @user_holder)
    respond_to do |format|
      format.html { redirect_to user_holder_medications_path(@user_holder), notice: 'Medication was successfully destroyed.' }
      format.json { head :no_content }
    end
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
