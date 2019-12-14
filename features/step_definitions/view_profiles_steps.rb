When /I go to the profile page of "(.*)"/ do |patient|
    visit profile_path(User.find_by_first_name(patient))
end

When /I fill in all fields with "(.*)"/ do |value|
    all_matching_inputs = page.all(:fillable_field)
    all_matching_inputs.each{ |e| e.set(value) }
end

When /I click "(.*)"/ do |value|

end

Then /I should be at the editing page of "(.*)"/ do |name|
    User.find_by_first_name name
end


Then /I should be at the profile of "(.*)"/ do |name|
    User.find_by_first_name name
end
