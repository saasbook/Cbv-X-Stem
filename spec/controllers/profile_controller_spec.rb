require 'rails_helper'

RSpec.describe PatientsController, type: :controller do

  describe "GET #profile" do
    fixtures :users
    it "returns a success response as patient" do
      @user = users(:patient_)
      sign_in @user
      UserHolder.create!(first_name: @user.first_name, last_name: @user.last_name, email: @user.email, user_id: @user.id)
      Profile.create!(first_name: @user.first_name, last_name: @user.last_name, email: @user.email, whatsapp: '6198089569', user_holder_id: @user.user_holder.id)
      get :profile
      expect(response).to be_success
    end
  end
#
end
