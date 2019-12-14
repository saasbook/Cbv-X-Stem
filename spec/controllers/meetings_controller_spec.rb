require 'rails_helper'

RSpec.describe MeetingsController, type: :controller do
  let(:valid_session) { {} }

  let(:invalid_attributes) {
    {}
  }

  describe "view meetings as doctor" do
    fixtures :users

    it "displays meetings index correctly" do
      @user = users(:doctor_)
      sign_in @user
      UserHolder.create!(first_name: @user.first_name, last_name: @user.last_name, email: @user.email, user_id: @user.id)
      Profile.create!(first_name: @user.first_name, last_name: @user.last_name, email: @user.email, whatsapp: '6198089569', user_holder_id: @user.user_holder.id)
      get :index, params: {"user_holder_id" => @user.user_holder.id}, session: valid_session
      expect(response).to be_success
    end
  end


  describe "view meetings as patient" do
    fixtures :users

    it "displays meetings index correctly" do
      @user = users(:patient_)
      sign_in @user
      UserHolder.create!(first_name: @user.first_name, last_name: @user.last_name, email: @user.email, user_id: @user.id)
      Profile.create!(first_name: @user.first_name, last_name: @user.last_name, email: @user.email, whatsapp: '6198089569', user_holder_id: @user.user_holder.id)
      get :index, params: {"user_holder_id" => @user.user_holder.id}, session: valid_session
      expect(response).to be_success
    end


  end
#
end
