module ProfileHelper

  def getProfileWithDefautCreation(userholder)
    if !current_user then return "Haven't logged in" end
    if not userholder.profile
      # create === new and save
      newprofile = Profile.create(first_name: current_user.first_name,
                                  last_name: current_user.last_name,
                                  email: current_user.email,
                                  user_holder_id: userholder.id)
    end
    @current_profile = userholder.profile
  end


  def getFullAddress(current_profile)
    if checkIfFullAddressAvailable then
      ( current_profile.address_line1 +
        emptyField(current_profile.address_line2) ? "" : current_profile.address_line2 +
        current_profile.city +
        current_profile.state +
        current_profile.country +
        current_profile.postal_code )
    else
      "Missing some of the fields for address, click edit to update your profile."
    end
  end

  def checkIfFullAddressAvailable
    return !( emptyField?(@current_profile.address_line1) ||
              emptyField?(@current_profile.city) ||
              emptyField?(@current_profile.state) ||
              emptyField?(@current_profile.country) ||
              emptyField?(@current_profile.postal_code) )
  end

  def emptyField?(field)
    field.nil? || field == ''
  end

end
