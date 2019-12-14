require 'rails_helper'

RSpec.describe AdminController, type: :controller do
  let(:valid_session) { {} }

  let(:invalid_attributes) {
    {}
  }

  describe "log in as doctor" do
    fixtures :users

    it "displays documents index correctly" do
      @user = users(:admin_)
      sign_in @user
      UserHolder.create!(first_name: @user.first_name, last_name: @user.last_name, email: @user.email, user_id: @user.id)
      Profile.create!(first_name: @user.first_name, last_name: @user.last_name, email: @user.email, whatsapp: '6198089569', user_holder_id: @user.user_holder.id)
      get :admin
      expect(response).to be_success
    end

    it "displays create new doc correctly" do
        @user = users(:admin_)
        sign_in @user
        UserHolder.create!(first_name: @user.first_name, last_name: @user.last_name, email: @user.email, user_id: @user.id)
        Profile.create!(first_name: @user.first_name, last_name: @user.last_name, email: @user.email, whatsapp: '6198089569', user_holder_id: @user.user_holder.id)
        get :new, params: {"user_holder_id" => @user.user_holder.id}, session: valid_session
        expect(response).to be_success
    end

    # it "makes new document correctly" do
    #     @user = users(:admin_)
    #     sign_in @user
    #     UserHolder.create!(first_name: @user.first_name, last_name: @user.last_name, email: @user.email, user_id: @user.id)
    #     Profile.create!(first_name: @user.first_name, last_name: @user.last_name, email: @user.email, whatsapp: '6198089569', user_holder_id: @user.user_holder.id)
    #     attributes = {"first_name" => "name1",
    #         "last_name" => "info1",
    #         "email" => "status1",
    #         "password" => "doc_name1",
    #         "password_confirmation" => "explanation1",
    #         "user_holder_id" => @user.user_holder.id,
    #       }
    #     post :create, params: {user: attributes}
    #     expect(response).to be_success
    # end
  end
end
