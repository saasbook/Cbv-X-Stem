require 'rails_helper'

RSpec.describe MessagesController, type: :controller do
	let(:valid_attributes) {
    { "sender_name" => "Kaijing",
      "sender_email" => "kaijing@berkeley.edu",
      "receiver_email" => "cbvxstem@gmail.com",
      "subject" => "hi",
      "body" => "hi",
      "user_holder_id" => "11",
    }
  }

  let(:invalid_attributes) {
    {}
  }

  let(:valid_session) { {} }

  describe "GET #index" do
    fixtures :users
    it "returns a success response" do
      @user = users(:kaijing_)
      sign_in @user
      UserHolder.create!(first_name: @user.first_name, last_name: @user.last_name, email: @user.email, user_id: @user.id)
      Profile.create!(first_name: @user.first_name, last_name: @user.last_name, email: @user.email, whatsapp: '5106978973', user_holder_id: @user.user_holder.id)
      get :index, params: { "user_holder_id" => @user.user_holder.id}, session: valid_session
      expect(response).to be_success
    end
  end
#
  describe "GET #show" do
    fixtures :users
    fixtures :messages
    it "returns a success response" do
      @user = users(:kaijing_)
      sign_in @user
      UserHolder.create!(first_name: @user.first_name, last_name: @user.last_name, email: @user.email, user_id: @user.id)
      @message = messages(:m1)
      get :show, params: {"user_holder_id" => @user.user_holder.id, id: @message.id}, session: valid_session
      expect(response).to be_success
    end
  end
#
  describe "GET #new" do
    fixtures :users
    fixtures :messages
    it "returns a success response" do
      @user = users(:kaijing_)
      sign_in @user
      UserHolder.create!(first_name: @user.first_name, last_name: @user.last_name, email: @user.email, user_id: @user.id)
      @message = messages(:m1)
      get :new, params: {"user_holder_id" => @user.user_holder.id}, session: valid_session
      expect(response.status).to eq(200)
    end

  end

  describe "GET #edit" do
    fixtures :users
    fixtures :messages
    it "returns a success response" do
      @user = users(:kaijing_)
      sign_in @user
      UserHolder.create!(first_name: @user.first_name, last_name: @user.last_name, email: @user.email, user_id: @user.id)
      @message = messages(:m1)
      get :edit, params: {"user_holder_id" => @user.user_holder.id, id: @message.id}, session: valid_session
      expect(response.status).to eq(200)
    end

  end

  describe "POST #create" do
    fixtures :users
    fixtures :messages
    context "with valid params" do
      it "creates a new message" do
        @user = users(:kaijing_)
        sign_in @user
        UserHolder.create!(first_name: @user.first_name, last_name: @user.last_name, email: @user.email, user_id: @user.id)
        post :create, params: {"user_holder_id" => @user.user_holder.id, message: valid_attributes}, session: valid_session
        message = Message.last
        expect(response).to redirect_to("/user_holders/"+ @user.user_holder.id.to_s + "/messages/" + message.id.to_s)
      end
    end
  end

  describe "PUT #update" do
    fixtures :users
    fixtures :messages

    context "with valid params" do
      it "updates the requested message" do
        @user = users(:kaijing_)
        sign_in @user
        UserHolder.create!(first_name: @user.first_name, last_name: @user.last_name, email: @user.email, user_id: @user.id)
        attributes = { "sender_name" => "Kaijing",
	      "sender_email" => "kaijing@berkeley.edu",
	      "receiver_email" => "cbvxstem@gmail.com",
	      "subject" => "hi",
	      "body" => "hi",
            "user_holder_id" => @user.user_holder.id,
          }
        message = Message.create!(attributes)
        attributes2 = { "sender_name" => "Kaijing1",
	      "sender_email" => "kaijing1@berkeley.edu",
	      "receiver_email" => "cbvxstem1@gmail.com",
	      "subject" => "hi1",
	      "body" => "hi1",
            "user_holder_id" => @user.user_holder.id,
          }
        put :update, params: {"id" => message.id ,"user_holder_id" => @user.user_holder.id, message: attributes2}, session: valid_session
        expect(response).to redirect_to("/user_holders/"+ @user.user_holder.id.to_s + "/messages/" + message.id.to_s)
      end
    end

  end

  describe "DELETE #destroy" do
    fixtures :users
    fixtures :messages

    it "destroys the requested message" do
      @user = users(:kaijing_)
      sign_in @user
      UserHolder.create!(first_name: @user.first_name, last_name: @user.last_name, email: @user.email, user_id: @user.id)
      @patient = users(:kaijing_)
      UserHolder.create!(first_name: @patient.first_name, last_name: @patient.last_name, email: @patient.email, user_id: @patient.id)
      attributes = { "sender_name" => "Kaijing",
	      "sender_email" => "kaijing@berkeley.edu",
	      "receiver_email" => "cbvxstem@gmail.com",
	      "subject" => "hi",
	      "body" => "hi",
	      "user_holder_id" => @patient.user_holder.id,
        }
      Profile.create!(first_name: @patient.first_name, last_name: @patient.last_name, email: @patient.email, whatsapp: '5106978973', user_holder_id: @patient.user_holder.id)
      message = Message.create!(attributes)

      @user = users(:kaijing_)
      sign_in @user
      UserHolder.create!(first_name: @user.first_name, last_name: @user.last_name, email: @user.email, user_id: @user.id)
      delete :destroy, params: {"id" => message.id ,"user_holder_id" => @patient.user_holder.id}, session: valid_session
      expect(response).to redirect_to("/user_holders/"+ @user.user_holder.id.to_s + "/messages")
    end
  end

end