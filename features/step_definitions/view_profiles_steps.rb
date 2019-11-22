When /I go to the profile page of "(.*)"/ do |patient|
    visit profile_path(User.find_by_first_name(patient))
end

When /I fill in all fields with "(.*)"/ do |value|
    all_matching_inputs = page.all(:fillable_field)
    all_matching_inputs.each{ |e| e.set(value) }
end
