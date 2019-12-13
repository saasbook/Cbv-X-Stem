Given /the following users exist/ do |user_table|
    user_table.hashes.each do |user|
      new_user = User.create(user)
      new_user.is_doctor = user[:is_doctor] == "true"
      new_user.save!
      new_user_holder = UserHolder.create!(first_name: new_user.first_name,
                                      last_name: new_user.last_name,
                                      email: new_user.email,
                                      user_id: new_user.id)
      newprofile = Profile.create(first_name: new_user.first_name,
                                  last_name: new_user.last_name,
                                  email: new_user.email,
                                  role: new_user.role,
                                  user_holder_id: new_user_holder.id)
    end
end
