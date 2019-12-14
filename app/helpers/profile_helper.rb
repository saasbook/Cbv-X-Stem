module ProfileHelper

  # LEGACY:: For backward compatency - remove if no function using it
  # - One-to-One initializer moved to one_to_one_relationship_initializer_concern
  def getProfileWithDefaultCreation(user_holder)
    @current_profile = user_holder.profile
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

  def update_profile_values(current_profile, modified)
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
end



  def emptyField?(field)
    field.nil? || field == ''
  end

  def is_doctor?
    return current_user.role == 'doctor'
  end
end
