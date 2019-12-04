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
<<<<<<< HEAD
    gon.whatsapp_action = params[:a] if params[:a] != ''
    gon.whatsapp_num = @user_holder.profile.whatsapp
=======
    @current_profile = Profile.find(params[:user_holder_id])
    params[:patient_name] = @current_profile.first_name + " " + @current_profile.last_name
    params[:patient_id] = @current_profile.user_holder_id
>>>>>>> add slide bar
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
        flash[:notice] = ['Medication was successfully created.' ]
        if @user_holder.user_setting.nil?
          @user_holder.user_setting = UserSetting.create(:user_holder_id => @user_holder.user_id)
        end
        if @user_holder.user_setting.create_med_email_notification == "Always notify me" || @user_holder.user_setting.create_med_email_notification == "Only notifiy me when specified" && params[:email_notif]
          send_email_notif("created")
        elsif @user_holder.user_setting.create_med_email_notification == "Never notify me" && params[:email_notif]
          flash[:notice] << "The patient has selected to never notify him or her by email when a medication is created so the email is not sent."
        end
        
        aa = ''
        if @user_holder.profile.whatsapp && (@user_holder.user_setting.create_med_whatsapp_notification == "Always notify me" || @user_holder.user_setting.create_med_whatsapp_notification == "Only notifiy me when specified" && params[:whatsapp_notif])
          aa = 'created'
        elsif !@user_holder.profile.whatsapp
          flash[:notice] << "The patient doesn't have a WhatsApp number."
        elsif @user_holder.user_setting.change_med_whatsapp_notification == "Never notify me" && params[:whatsapp_notif]
          flash[:notice] << "The patient has selected to never notify him or her through WhatsApp when a medication is created so the message is not sent."
        end

        format.html { redirect_to user_holder_medications_path(@user_holder, a: aa)}
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
        flash[:notice] = ['Medication was successfully updated.']
        if @user_holder.user_setting.nil?
          @user_holder.user_setting = UserSetting.create(:user_holder_id => @user_holder.user_id)
        end
        
        if @user_holder.user_setting.change_med_email_notification == "Always notify me" || @user_holder.user_setting.change_med_email_notification == "Only notifiy me when specified" && params[:email_notif]
          send_email_notif("updated")
        elsif @user_holder.user_setting.change_med_email_notification == "Never notify me" && params[:email_notif]
          flash[:notice] << "The patient has selected to never notify him or her by email when a doctor changes his or her medication so the email is not sent."
        end

        aa = ''
        if @user_holder.profile.whatsapp && (@user_holder.user_setting.change_med_whatsapp_notification == "Always notify me" || (@user_holder.user_setting.change_med_whatsapp_notification == "Only notifiy me when specified" && params[:whatsapp_notif]))
          aa = 'updated'
        elsif !@user_holder.profile.whatsapp
          flash[:notice] << "The patient doesn't have a WhatsApp number."
        elsif @user_holder.user_setting.change_med_whatsapp_notification == "Never notify me" && params[:whatsapp_notif]
          flash[:notice] << "The patient has selected to never notify him or her through WhatsApp when his or her medication is changed so the message is not sent."
        end

        format.html { redirect_to user_holder_medications_path(@user_holder, a: aa)}
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

  def send_email_notif(action)
    @message = Message.new(:sender_name => current_user.first_name + " " + current_user.last_name)
    @message.receiver_email = @user_holder.email
    MessageMailer.general_notification(@message, "medication", action).deliver
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
