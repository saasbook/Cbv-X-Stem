class PatientsController < ApplicationController
  include ProfileHelper
  include UserActivitiesHelper
  include ApplicationHelper

  before_action :getUserHolderWithDefaultCreation
  def profile
    if current_user.role == 'guest'
        flash[:error] = "You must be logged in to view your profile."
        redirect_to root_path
        return
    end
    #redirect from search Patients and the current user is a doctor
    #TO DO verify request from doctor
    if (!params[:search_id].nil? && !params[:search_id].empty?)
      @current_profile = Profile.where(:user_holder_id => params[:search_id]).first
    else
      #TODO redirect user to new (creation) page if profile not exist. (with name and email auto-filled)
      # - The patient should be urged to fill up their profile when they visit the profile first time.
      # - It doesn't make sure to have profile that has required field not filled.
      @current_profile = getProfileWithDefaultCreation(@user_holder)
    end

    # IMPORTANT: call profile class's calculate_age_from_birthday function
    # and store in variable
    @age = @current_profile.calculate_age_from_birthday(@current_profile.birthday)
  end

  def setting
    @current_holder = @current_user.user_holder
    @current_setting = @current_holder.user_setting
    if @current_setting.nil?
     @current_setting = UserSetting.create(:user_holder_id => @current_holder.user_id)
    end
  end

  def update_setting
    @current_user = User.find(params[:id])
    @current_holder = @current_user.user_holder
    @current_setting = @current_holder.user_setting
    @my_setting = params[:user_setting]

    @current_setting.create_doc_email_notification = @my_setting[:create_doc_email_notification]
    @current_setting.create_doc_whatsapp_notification = @my_setting[:create_doc_whatsapp_notification]
    @current_setting.change_doc_email_notification = @my_setting[:change_doc_email_notification]
    @current_setting.change_doc_whatsapp_notification = @my_setting[:change_doc_whatsapp_notification]
    @current_setting.require_doc_email_notification = @my_setting[:require_doc_email_notification]
    @current_setting.require_doc_whatsapp_notification = @my_setting[:require_doc_whatsapp_notification]
    @current_setting.create_tre_email_notification = @my_setting[:create_tre_email_notification]
    @current_setting.create_tre_whatsapp_notification = @my_setting[:create_tre_whatsapp_notification]
    @current_setting.change_tre_email_notification = @my_setting[:change_tre_email_notification]
    @current_setting.change_tre_whatsapp_notification = @my_setting[:change_tre_whatsapp_notification]
    @current_setting.create_med_email_notification = @my_setting[:create_med_email_notification]
    @current_setting.create_med_whatsapp_notification = @my_setting[:create_med_whatsapp_notification]
    @current_setting.change_med_email_notification = @my_setting[:change_med_email_notification]
    @current_setting.change_med_whatsapp_notification = @my_setting[:change_med_whatsapp_notification]
    @current_setting.save!

    if @my_setting[:create_doc_email_notification] == "Never notify me"
      flash[:notice] = ["You select to never notify you by email when a document is added for you."]
    else
      flash[:notice] = []
    end
    if @my_setting[:change_doc_email_notification] == "Never notify me"
      flash[:notice] << "You select to never notify you by email when your document is changed."
    end
    if @my_setting[:require_doc_email_notification] == "Never notify me"
      flash[:notice] << "You select to never notify you by email when a change for your document is required."
    end
    if @my_setting[:create_tre_email_notification] == "Never notify me"
      flash[:notice] << ["You select to never notify you by email when a treatment is added for you."]
    end
    if @my_setting[:change_tre_email_notification] == "Never notify me"
      flash[:notice] << "You select to never notify you by email when your treatment is changed."
    end
    if @my_setting[:create_med_email_notification] == "Never notify me"
      flash[:notice] << ["You select to never notify you by email when a meditation is added for you."]
    end
    if @my_setting[:change_med_email_notification] == "Never notify me"
      flash[:notice] << "You select to never notify you by email when your meditation is changed."
    end
    redirect_to patient_setting_path

  end


  def new
    # must be logged in
    if current_user.role == 'guest'
      flash[:error] = "You must be logged in to view your profile."
      redirect_to root_path
    else
      # get user_holder instance, else create one.
      @user_holder = getUserHolderWithDefaultCreation
      # if no profile yet, create one.
      @new_profile = getProfileWithDefaultCreation(@user_holder)
    end
  end

  def show
    # must be logged in
    if not is_doctor?
        flash[:error] = "You are not authorized to view this page."
        redirect_to root_path
    else
        @current_profile = Profile.find(params[:id])
        render 'profile'
    end
  end

  def edit
    if current_user.role == 'guest'
        flash[:error] = "You must be logged in to edit a profile."
        redirect_to root_path
    elsif not is_doctor?
        holder = current_user.user_holder
        # Check that user_holder instance has been created.
        if not holder.profile.nil?
            current_user_profile = current_user.user_holder.profile
        else
            redirect_to patient_new_profile_path(current_user)
            return
        end

        # Patients can only edit their own profiles
        @profile_to_edit = Profile.find(params[:id])
        if @profile_to_edit == current_user_profile
            render 'edit'
        else
            flash[:error] = "You are not authorized to edit this profile."
            redirect_to root_path
        end
    else # Doctor is logged in
        @profile_to_edit = Profile.find(params[:id])
        render 'edit'
    end
  end

  def update
    begin

      modified = params[:profile]
      current_profile = Profile.find params[:id] # Profile.where(:id => params[:id])
      temp_profile = current_profile.as_json
      # current_profile.update_attributes!(params[:profile])
      current_profile.doctor = "Bill Gates"
      current_profile.first_name = modified[:first_name]
      current_profile.last_name = modified[:last_name]
      current_profile.whatsapp = modified[:whatsapp]
      current_profile.email = modified[:email]
      current_profile.address_line1 = modified[:address_line1]
      current_profile.address_line2= modified[:address_line2]
      current_profile.city = modified[:city]
      current_profile.state = modified[:state]
      current_profile.country= modified[:country]
      current_profile.postal_code = modified[:postal_code]
      current_profile.phone = modified[:phone]
      current_profile.reached_through = modified[:reached_through]
      current_profile.birthday = modified[:birthday]
      current_profile.sex = modified[:sex]
      current_profile.health_plan = modified[:health_plan]
      current_profile.contacts = modified[:contacts]
      current_profile.weight = modified[:weight]
      current_profile.height = modified[:height]
      current_profile.smoke = modified[:smoke].to_s.downcase == "true"
      current_profile.smoke_a_day = modified[:smoke_a_day]
      current_profile.alcohol = modified[:alcohol].to_s.downcase == "true"
      current_profile.alcohol_use = modified[:alcohol_use]
      current_profile.current_job = modified[:current_job]
      current_profile.exercise = modified[:exercise]
      current_profile.doctor = modified[:doctor]
      if current_profile.save! then
        log_change_to_user_activities('profile', 'edit', current_user.user_holder, current_profile.user_holder, temp_profile, current_profile.as_json)
      end


      if @current_user.user_holder.profile == current_profile
        flash[:notice] = "Your profile has been successfully updated."
        redirect_to patient_profile_path
      else
        flash[:notice] = "#{current_profile.first_name} #{current_profile.last_name}'s profile has been successfully updated."
        redirect_to patient_path(current_profile)
      end
    rescue StandardError
      flash[:error] = "One of the fields was not filled out correctly."
      redirect_to patient_edit_profile_path(current_profile)
    end
  end

end
