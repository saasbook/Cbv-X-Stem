# require 'rails_helper'
#
#
# RSpec.describe 'Homepage', type: :feature , js:true do
#   include Warden::Test::Helpers
#   fixtures :users
#   fixtures :medications
#   before do
#      # Sign the User in
#      Warden.test_mode!
#      @user = users(:patient_)
#      sign_in @user
#    end
#
#   scenario "visit" do
#     visit "/"
#     expect(page).to have_title "CbvXStem"
#     expect(page).to have_css "h3", text: "Welcome back"
#     expect(page).to be_accessible.according_to(:wcag2a).checking("html-has-lang", "html-lang-valid")
#     expect(page).to be_accessible.according_to(:wcag2a).checking("color-contrast")
#     expect(page).to be_accessible.according_to(:wcag2a).checking("document-title", "empty-heading")
#     expect(page).to be_accessible.according_to(:wcag2a).checking(:label, "area-alt", "button-name", "image-alt", "input-button-name", "input-image-alt")
#     expect(page).to be_accessible.according_to(:wcag2a).checking("label-content-name-mismatch", "label-title-only")
#     expect(page).to be_accessible.according_to(:wcag2a).checking("layout-table", "link-in-text-block", "link-name")
#     expect(page).to be_accessible.according_to(:wcag2a).checking(:list, "listitem")
#     expect(page).to be_accessible.according_to(:wcag2a).checking(:tabindex, :accesskeys)
#   end
#
#   scenario "visit contact" do
#     visit "/contact"
#     expect(page).to be_accessible.according_to(:wcag2a).checking("html-has-lang", "html-lang-valid")
#     expect(page).to be_accessible.according_to(:wcag2a).checking("color-contrast")
#     expect(page).to be_accessible.according_to(:wcag2a).checking("document-title", "empty-heading")
#     expect(page).to be_accessible.according_to(:wcag2a).checking(:label, "area-alt", "button-name", "image-alt", "input-button-name", "input-image-alt")
#     expect(page).to be_accessible.according_to(:wcag2a).checking("label-content-name-mismatch", "label-title-only")
#     expect(page).to be_accessible.according_to(:wcag2a).checking("layout-table", "link-in-text-block", "link-name")
#     expect(page).to be_accessible.according_to(:wcag2a).checking(:list, "listitem")
#     expect(page).to be_accessible.according_to(:wcag2a).checking(:tabindex, :accesskeys)
#   end
#
#   scenario "visit about" do
#     visit "/about-me"
#     expect(page).to be_accessible.according_to(:wcag2a).checking("html-has-lang", "html-lang-valid")
#     expect(page).to be_accessible.according_to(:wcag2a).checking("color-contrast")
#     expect(page).to be_accessible.according_to(:wcag2a).checking("document-title", "empty-heading")
#     expect(page).to be_accessible.according_to(:wcag2a).checking(:label, "area-alt", "button-name", "image-alt", "input-button-name", "input-image-alt")
#     expect(page).to be_accessible.according_to(:wcag2a).checking("label-content-name-mismatch", "label-title-only")
#     expect(page).to be_accessible.according_to(:wcag2a).checking("layout-table", "link-in-text-block", "link-name")
#     expect(page).to be_accessible.according_to(:wcag2a).checking(:list, "listitem")
#     expect(page).to be_accessible.according_to(:wcag2a).checking(:tabindex, :accesskeys)
#   end
#
#
# end
