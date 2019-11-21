module ProfileHelper

  # LEGACY:: For backward compatency - remove if no function using it
  # - One-to-One initializer moved to one_to_one_relationship_initializer_concern
  def getProfileWithDefaultCreation(userholder)
    @current_profile = userholder.profile
  end


  def getFullAddress(current_profile)
    if checkIfFullAddressAvailable then
      ( current_profile.address_line1 + " " +
        current_profile.address_line2 + " " +
        current_profile.city + " " +
        current_profile.state + " " +
        current_profile.country + " " +
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

  def is_doctor?
    return current_user.role == 'doctor'
  end
end
