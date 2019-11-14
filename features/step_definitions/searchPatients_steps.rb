Given /the following patients exist/ do |patients_table|
    patients_table.hashes.each do |patient|
      new_user = User.create(patient)
      new_user.save!
      new_user_holder = UserHolder.create!(first_name: new_user.first_name,
                                      last_name: new_user.last_name,
                                      email: new_user.email,
                                      user_id: new_user.id)
      newprofile = Profile.create(first_name: new_user.first_name,
                                  last_name: new_user.last_name,
                                  email: new_user.email,
                                  user_holder_id: new_user_holder.id)
    end
end

Then /The number of patients should be (.*)/ do |size|
    expect(Profile.all.size).to eq size.to_i
end
