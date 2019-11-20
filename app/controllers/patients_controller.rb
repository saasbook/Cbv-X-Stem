class PatientsController < ApplicationController
  include ProfileHelper
  include UserActivitiesHelper
  skip_authorize_resource

  def profile
    if current_user.nil?
        flash[:error] = "You must be logged in to view your profile."
        redirect_to root_path
        return
    end
    #redirect from search Patients and the current user is a doctor
    #TO DO verify request from doctor
    if (!params[:search_id].nil? && !params[:search_id].empty?)
      @current_profile = Profile.where(:user_holder_id => params[:search_id]).first
    else
      # TODO Have userholder created when the user sign up. (Waiting for doctor authentication: UID#169251963)
      # - UserHolder should be created when the user creates its account.

      # Moves default-create helper function to applicationHelper, so it can be shared with all patient and doctor function.
      # HACK Mock the initial UserHolder until ^TODO finished.
      @current_profile = @user_holder.profile
      #TODO redirect user to new (creation) page if profile not exist. (with name and email auto-filled)
      # - The patient should be urged to fill up their profile when they visit the profile first time.
      # - It doesn't make sure to have profile that has required field not filled.
      if not @user_holder.profile
        # HACK Mock the initial profile until ^TODO finished.
        @current_profile = getProfileWithDefaultCreation(@user_holder)
      end
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

  def edit_setting
    @current_holder = @current_user.user_holder
    @current_setting = @current_holder.user_setting
    if @current_setting.nil?
     @current_setting = UserSetting.create(:user_holder_id => @current_holder.user_id)
    end

    render 'edit_setting'
  end

  def update_setting
    @current_user = User.find(params[:id])
    @current_holder = @current_user.user_holder
    @current_setting = @current_holder.user_setting
    @my_setting = params[:user_setting]


    @current_setting.email_notification = @my_setting[:email_notification].to_s.downcase == "true"
    @current_setting.whatsapp_notification = @my_setting[:whatsapp_notification].to_s.downcase == "true"
    @current_setting.save!

    redirect_to patient_setting_path

  end





  def new
    # must be logged in
    if not current_user.nil?
        # get user_holder instance, else create one.
        @user_holder = getUserHolderWithDefaultCreation
        # if no profile yet, create one.
        @new_profile = getProfileWithDefaultCreation(@user_holder)
    else
        flash[:error] = "You must be logged in to view your profile."
        redirect_to root_path
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
    # if the user is logged in
    # if not current_user.nil?
    #     holder = current_user.user_holder
    #     # if there is a user holder for the user
    #     if not holder.profile.nil?
    #         @profile_to_edit = current_user.user_holder.profile
    #     else
    #         redirect_to patient_new_profile_path(current_user)
    #     end
    # else
    #     redirect_to patient_new_profile_path(current_user)
    # end
    if current_user.nil?
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
        log_change_to_user_activities('profile', 'edit', current_user, temp_profile, current_profile.as_json)
      end

      flash[:notice] = "#{current_profile.first_name} #{current_profile.last_name}'s profile has been successfully updated."
      redirect_to patient_profile_path
    rescue StandardError
      flash[:error] = "One of the fields was not filled out correctly."
      redirect_to patient_edit_profile_path(current_profile)
    end
  end

end
