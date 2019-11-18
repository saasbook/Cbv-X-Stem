Given /the following users exist/ do |user_table|
    user_table.hashes.each do |user|
      new_user = User.create(user)
      new_user.is_doctor = user[:is_doctor] == "true"
      new_user.save!
      new_user.confirm!
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

Given /I am logged in as "(.*)"/ do |user|
    u = User.find_by_first_name(user)
    sign_in u
end

# Given /I am logged in as "(.*)"/ do |user|
#     step %{I am on the login page}
#     step %{I log in as "#{user}"}
# end
#
# When /I log in as "(.*)"/ do |user|
#     u = User.find_by_first_name(user)
#     step %{I fill in "Email" with "#{u.email}"}
#     step %{I fill in "Password" with "#{u.password}"}
#     step %{I press "Log in"}
# end

When /I go to the profile page of "(.*)"/ do |patient|
    visit profile_path(User.find_by_first_name(patient))
end

When /I fill in all fields with "(.*)"/ do |value|
    all_matching_inputs = page.all(:fillable_field)
    all_matching_inputs.each{ |e| e.set(value) }
end
