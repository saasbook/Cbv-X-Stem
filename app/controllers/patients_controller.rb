class PatientsController < ApplicationController
  include ProfileHelper
  include ApplicationHelper

  def profile

    # TODO Have userholder created when the user sign up. (Waiting for doctor authentication: UID#169251963)
    # - UserHolder should be created when the user creates its account.

    # Moves default-create helper function to applicationHelper, so it can be shared with all patient and doctor function.
    # HACK Mock the initial UserHolder until ^TODO finished.
    holder = getUserHolderWithDefaultCreation
    @current_profile = holder.profile
    #TODO redirect user to new (creation) page if profile not exist. (with name and email auto-filled)
    # - The patient should be urged to fill up their profile when they visit the profile first time.
    # - It doesn't make sure to have profile that has required field not filled.
    if not holder.profile
      # HACK Mock the initial profile until ^TODO finished.
      @current_profile = getProfileWithDefautCreation(holder)
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
