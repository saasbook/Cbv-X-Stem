Then /The number of patients should be (.*)/ do |size|
    expect(Profile.all.size).to eq size.to_i
end

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
    expect(page.body.index(e1) < page.body.index(e2))
end
