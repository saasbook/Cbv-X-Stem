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

  end

  def edit
    @profile_to_edit = current_user.user_holder.profile
  end

  def update
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
    current_profile.save!
    redirect_to patient_profile_path
  end

end
