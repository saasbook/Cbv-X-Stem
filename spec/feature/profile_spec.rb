# require 'rails_helper'
#
# RSpec.describe Profile, type: :feature , js:true do
#   include Warden::Test::Helpers
#   fixtures :users
#   before do
#      # Sign the User in
#      Warden.test_mode!
#      @user = users(:patient_)
#      sign_in @user
#      UserHolder.create!(first_name: @user.first_name, last_name: @user.last_name, email: @user.email, user_id: @user.id)
#      Profile.create!(first_name: @user.first_name, last_name: @user.last_name, email: @user.email, whatsapp: '6198089569', user_holder_id: @user.user_holder.id)
#    end
#
#   scenario "visit" do
#     visit patient_profile_path(@user.user_holder)
#     expect(page).to be_accessible.according_to(:wcag2a).checking("html-has-lang", "html-lang-valid")
#     expect(page).to be_accessible.according_to(:wcag2a).checking("color-contrast")
#     expect(page).to be_accessible.according_to(:wcag2a).checking("document-title", "empty-heading")
#     expect(page).to be_accessible.according_to(:wcag2a).checking(:label, "area-alt", "button-name", "image-alt", "input-button-name", "input-image-alt")
#     expect(page).to be_accessible.according_to(:wcag2a).checking("label-content-name-mismatch", "label-title-only")
#     expect(page).to be_accessible.according_to(:wcag2a).checking("layout-table", "link-in-text-block", "link-name")
#     expect(page).to be_accessible.according_to(:wcag2a).checking(:list, "listitem")
#     expect(page).to be_accessible.according_to(:wcag2a).checking(:tabindex, :accesskeys)
#
#   end
#
#
# end
