require 'rails_helper'

RSpec.describe DocumentationsController, type: :controller do
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

    it "displays meetings show correctly" do
        @user = users(:doctor_)
        sign_in @user
        UserHolder.create!(first_name: @user.first_name, last_name: @user.last_name, email: @user.email, user_id: @user.id)
        Profile.create!(first_name: @user.first_name, last_name: @user.last_name, email: @user.email, whatsapp: '6198089569', user_holder_id: @user.user_holder.id)
        get :new, params: {"user_holder_id" => @user.user_holder.id}, session: valid_session
        expect(response).to be_success
    end

    it "makes new document correctly" do
        @user = users(:doctor_)
        sign_in @user
        UserHolder.create!(first_name: @user.first_name, last_name: @user.last_name, email: @user.email, user_id: @user.id)
        Profile.create!(first_name: @user.first_name, last_name: @user.last_name, email: @user.email, whatsapp: '6198089569', user_holder_id: @user.user_holder.id)
        attributes = {"status" => "name1",
            "location" => "info1",
            "description" => "status1",
            "category" => "doc_name1",
            "name" => "name2",
            "patient_id" => 1,
            "user_holder_id" => @user.user_holder.id,
          }
        post :create, params: {"user_holder_id" => @user.user_holder.id, documentation: attributes}
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
      get :show_doctor_schedule, params: {"user_holder_id" => @user.user_holder.id}, session: valid_session
      expect(response).to be_success
    end


  end
#
end
