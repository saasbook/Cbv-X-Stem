require 'rails_helper'

RSpec.describe Treatment, type: :feature , js:true do
  include Warden::Test::Helpers
  fixtures :users
  before do
     # Sign the User in
     Warden.test_mode!
     @user = users(:patient_)
     sign_in @user
   end

  scenario "visit" do
    visit "/user_holders/"+ @user.user_holder.id.to_s + "/treatments"
    # expect(page).to have_title "Cbvxstem"
    # expect(page).to have_css "h2", text: "Welcome back"
    expect(page).to be_accessible.according_to(:wcag2a).checking("color-contrast")
  end


end
