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
    # #redirect from search Patients and the current user is a doctor
    # #TO DO verify request from doctor
    # if (!params[:search_id].nil? && !params[:search_id].empty?)
    #   @current_profile = Profile.where(:user_holder_id => params[:search_id]).first
    # else
    #   #TODO redirect user to new (creation) page if profile not exist. (with name and email auto-filled)
    #   # - The patient should be urged to fill up their profile when they visit the profile first time.
    #   # - It doesn't make sure to have profile that has required fieldnot filled.
    #   @current_profile = getProfileWithDefaultCreation(@user_holder)
    # end

    # IMPORTANT: call profile class's calculate_age_from_birthday function
    # and store in variable
    @current_profile = getProfileWithDefaultCreation(@user_holder)
    redirect_with_userid(@current_user.id)
    @age = @current_profile.calculate_age_from_birthday(@current_profile.birthday)
    @name = @current_profile.first_name + " " + @current_profile.last_name
    @is_doctor = is_doctor?()
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
    @temp_setting = @current_setting.as_json

    @my_setting = params[:user_setting]
    for action in ["create", "change"]
      for activity in ["doc", "tre", "med"]
        for tool in ["email", "whatsapp"]
          @current_setting[action + "_" + activity + "_" + tool + "_notification"] = @my_setting[action + "_" + activity + "_" + tool + "_notification"]
        end
      end
    end

    #@current_setting.create_doc_email_notification = @my_setting[:create_doc_email_notification]
    #@current_setting.create_doc_whatsapp_notification = @my_setting[:create_doc_whatsapp_notification]
    #@current_setting.change_doc_email_notification = @my_setting[:change_doc_email_notification]
    #@current_setting.change_doc_whatsapp_notification = @my_setting[:change_doc_whatsapp_notification]
    @current_setting.require_doc_email_notification = @my_setting[:require_doc_email_notification]
    @current_setting.require_doc_whatsapp_notification = @my_setting[:require_doc_whatsapp_notification]
    #@current_setting.create_tre_email_notification = @my_setting[:create_tre_email_notification]
    #@current_setting.create_tre_whatsapp_notification = @my_setting[:create_tre_whatsapp_notification]
    #@current_setting.change_tre_email_notification = @my_setting[:change_tre_email_notification]
    #@current_setting.change_tre_whatsapp_notification = @my_setting[:change_tre_whatsapp_notification]
    #@current_setting.create_med_email_notification = @my_setting[:create_med_email_notification]
    #@current_setting.create_med_whatsapp_notification = @my_setting[:create_med_whatsapp_notification]
    #@current_setting.change_med_email_notification = @my_setting[:change_med_email_notification]
    #@current_setting.change_med_whatsapp_notification = @my_setting[:change_med_whatsapp_notification]

    if @current_setting.save!
      log_change_to_user_activities('Settings', 'Edit', @current_holder, @current_holder, \
                                    @temp_setting, @current_setting.as_json)


      flash[:notice] = ["Changes have been successfully saved."]
      for action in ["create", "change"]
        for activity in ["doc", "tre", "med"]
          if @my_setting[action + "_" + activity + "_email_notification"] == "Never notify me"
            if action == "create" then aaction = "created" else aaction = "changed" end
            aactivity = rename(activity)
            flash[:notice] << "You select to never notify you by email when a " + aactivity + " is " + aaction +"."
          end
        end
      end

    #if @my_setting[:create_doc_email_notification] == "Never notify me"
    #  flash[:notice] << "You select to never notify you by email when a document is added for you."
    #end
    #if @my_setting[:change_doc_email_notification] == "Never notify me"
    #  flash[:notice] << "You have selected to never notify you by email when your document is changed."
    #end
      if @my_setting[:require_doc_email_notification] == "Never notify me"
        flash[:notice] << "You have selected to never notify you by email when a change for your document is required."
      end
    #if @my_setting[:create_tre_email_notification] == "Never notify me"
    #  flash[:notice] << "You have selected to never notify you by email when a treatment is added for you."
    #end
    #if @my_setting[:change_tre_email_notification] == "Never notify me"
    #  flash[:notice] << "You have selected to never notify you by email when your treatment is changed."
    #end
    #if @my_setting[:create_med_email_notification] == "Never notify me"
    #  flash[:notice] << "You have selected to never notify you by email when a meditation is added for you."
    #end
    #if @my_setting[:change_med_email_notification] == "Never notify me"
    #  flash[:notice] << "You have selected to never notify you by email when your meditation is changed."
    #end
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
    redirect_with_userid(@current_user.id)
    check_login_as_doctor('profile')
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
      current_profile = Profile.find params[:id]
      temp_profile = current_profile.as_json # current_profile.update_attributes!(params[:profile])
      update_profile_values(current_profile, modified)

      if current_profile.save! then
        log_change_to_user_activities('Profile', 'Edit', current_user.user_holder, current_profile.user_holder, temp_profile, current_profile.as_json)
      end

      if @current_user.user_holder.profile == current_profile
        flash[:notice] = "Your profile has been successfully updated."
        redirect_to patient_profile_path
      else
        flash[:notice] = "#{current_profile.first_name} #{current_profile.last_name}'s profile has been successfully updated."
        redirect_to patient_path(current_profile)
      end
    rescue StandardError
      flash[:error] = "An error occurred. Please check all fields were filled out correctly and try again."
      redirect_to patient_edit_profile_path(current_profile)
    end
  end

  def rename(activity)
    if activity == "tre"
      "treatment"
    elsif activity == "med"
      "medication"
    else
      "documentation"
    end
  end

end
