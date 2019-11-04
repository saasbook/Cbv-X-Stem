class PatientsController < ApplicationController
  def profile
    holder = current_user.user_holder

    # create a UserHolder object if user does not have one already
    if holder.nil?
        newuserholder = UserHolder.create(first_name: current_user.first_name, last_name: current_user.last_name, email: current_user.email)
        newuserholder.user_id = current_user.id
        newuserholder.save!

        current_user.user_holder = newuserholder
        current_user.save!
        holder = current_user.user_holder
    end

    # create a profile if userholder object doesn't have one already
    if not holder.profile
        newprofile = Profile.create(first_name: current_user.first_name, last_name: current_user.last_name, email: current_user.email)
        newprofile.user_holder_id = holder.id
        newprofile.save!

        holder.profile = newprofile
        holder.save!
        @current_profile = holder.profile
        @current_profile.created_at = Time.now
        @current_profile.updated_at = Time.now
        @current_profile.save!
    else
        @current_profile = holder.profile
    end

    # IMPORTANT: call profile class's calculate_age_from_birthday function
    # and store in variable
    @age = @current_profile.calculate_age_from_birthday(@current_profile.birthday)
  end

  def edit
    @profile_to_edit = current_user.user_holder.profile
  end

  def update
    begin
        modified = params[:profile]
        current_profile = Profile.find params[:id] # Profile.where(:id => params[:id])
        # current_profile.update_attributes!(params[:profile])
        current_profile.first_name = modified[:first_name]
        current_profile.last_name = modified[:last_name]
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
        current_profile.save!
        redirect_to patient_profile_path
    rescue StandardError
        flash[:error] = "One of the fields was not filled out correctly."
        redirect_to patient_edit_profile_path(current_profile)
    end
  end

end
