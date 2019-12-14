require 'rails_helper'

RSpec.describe DocumentationsController, type: :controller do
  let(:valid_session) { {} }

  let(:invalid_attributes) {
    {}
  }

  describe "log in as doctor" do
    fixtures :users

    it "displays documents index correctly" do
      @user = users(:doctor_)
      sign_in @user
      UserHolder.create!(first_name: @user.first_name, last_name: @user.last_name, email: @user.email, user_id: @user.id)
      Profile.create!(first_name: @user.first_name, last_name: @user.last_name, email: @user.email, whatsapp: '6198089569', user_holder_id: @user.user_holder.id)
      get :index, params: {"user_holder_id" => @user.user_holder.id}, session: valid_session
      expect(response).to be_success
    end

    it "displays create new doc correctly" do
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
        attributes = {"name" => "name1",
            "documents_info" => "info1",
            "documents_status" => "status1",
            "documents_name" => "doc_name1",
            "documents_explanation" => "explanation1",
            "user_holder_id" => @user.user_holder.id,
          }
        post :create, params: {"user_holder_id" => @user.user_holder.id, documentation: attributes}
        expect(response).to be_success
    end
  end
#
describe "log in as patient" do
  fixtures :users

  it "displays documents index correctly" do
    @user = users(:patient_)
    sign_in @user
    UserHolder.create!(first_name: @user.first_name, last_name: @user.last_name, email: @user.email, user_id: @user.id)
    Profile.create!(first_name: @user.first_name, last_name: @user.last_name, email: @user.email, whatsapp: '6198089569', user_holder_id: @user.user_holder.id)
    get :index, params: {"user_holder_id" => @user.user_holder.id}, session: valid_session
    expect(response).to be_success
  end

  it "displays create new doc correctly" do
      @user = users(:patient_)
      sign_in @user
      UserHolder.create!(first_name: @user.first_name, last_name: @user.last_name, email: @user.email, user_id: @user.id)
      Profile.create!(first_name: @user.first_name, last_name: @user.last_name, email: @user.email, whatsapp: '6198089569', user_holder_id: @user.user_holder.id)
      get :new, params: {"user_holder_id" => @user.user_holder.id}, session: valid_session
      expect(response).to be_success
  end

  it "makes new document correctly" do
      @user = users(:patient_)
      sign_in @user
      UserHolder.create!(first_name: @user.first_name, last_name: @user.last_name, email: @user.email, user_id: @user.id)
      Profile.create!(first_name: @user.first_name, last_name: @user.last_name, email: @user.email, whatsapp: '6198089569', user_holder_id: @user.user_holder.id)
      attributes = {"name" => "name1",
          "documents_info" => "info1",
          "documents_status" => "status1",
          "documents_name" => "doc_name1",
          "documents_explanation" => "explanation1",
          "user_holder_id" => @user.user_holder.id,
        }
      post :create, params: {"user_holder_id" => @user.user_holder.id, documentation: attributes}
      expect(response).to be_success
  end
end
end
