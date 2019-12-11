require 'rails_helper'

RSpec.describe TreatmentsController, type: :controller do
  let(:valid_attributes) {
    { "provider" => "provider1",
      "name" => "name1",
      "location" => "location1",
      "status" => "status1",
      "description" => "description1",
      "user_holder_id" => "1",
    }
  }

  let(:invalid_attributes) {
    {}
  }

  let(:valid_session) { {} }

  describe "GET #index" do
    fixtures :users
    it "returns a success response" do
      @user = users(:patient_)
      sign_in @user
      UserHolder.create!(first_name: @user.first_name, last_name: @user.last_name, email: @user.email, user_id: @user.id)
      Profile.create!(first_name: @user.first_name, last_name: @user.last_name, email: @user.email, whatsapp: '6198089569', user_holder_id: @user.user_holder.id)
      get :index, params: { "user_holder_id" => @user.user_holder.id}, session: valid_session
      expect(response).to be_success
    end
  end
#
  describe "GET #show" do
    fixtures :users
    fixtures :treatments
    it "returns a success response" do
      @user = users(:patient_)
      sign_in @user
      UserHolder.create!(first_name: @user.first_name, last_name: @user.last_name, email: @user.email, user_id: @user.id)
      @treatment = treatments(:t1)
      get :show, params: {"user_holder_id" => @user.user_holder.id, id: @treatment.id}, session: valid_session
      expect(response).to be_success
    end
  end
#
  describe "GET #new" do
    fixtures :users
    fixtures :treatments
    it "returns a success response" do
      @user = users(:patient_)
      sign_in @user
      UserHolder.create!(first_name: @user.first_name, last_name: @user.last_name, email: @user.email, user_id: @user.id)
      @treatment = treatments(:t1)
      get :new, params: {"user_holder_id" => @user.user_holder.id}, session: valid_session
      expect(response).to redirect_to "/user_holders/"+ @user.user_holder.id.to_s + "/treatments"
    end

  end
#
  describe "GET #edit" do
    fixtures :users
    fixtures :treatments
    it "returns a success response" do
      @user = users(:patient_)
      sign_in @user
      UserHolder.create!(first_name: @user.first_name, last_name: @user.last_name, email: @user.email, user_id: @user.id)
      @treatment = treatments(:t1)
      get :edit, params: {"user_holder_id" => @user.user_holder.id, id: @treatment.id}, session: valid_session
      expect(response).to redirect_to "/user_holders/"+ @user.user_holder.id.to_s + "/treatments"
    end

  end
#


  describe "POST #create - Patient" do
    fixtures :users
    fixtures :treatments
    context "with valid params" do
      it "creates a new Treatment" do
        @user = users(:patient_)
        sign_in @user
        UserHolder.create!(first_name: @user.first_name, last_name: @user.last_name, email: @user.email, user_id: @user.id)
        post :create, params: {"user_holder_id" => @user.user_holder.id, treatment: valid_attributes}, session: valid_session
        expect(response).to redirect_to("/user_holders/"+ @user.user_holder.id.to_s + "/treatments")
      end
    end

    context "with invalid params" do
      it "creates a new Treatment" do
        @user = users(:patient_)
        sign_in @user
        UserHolder.create!(first_name: @user.first_name, last_name: @user.last_name, email: @user.email, user_id: @user.id)
        post :create, params: {"user_holder_id" => @user.user_holder.id, treatment: invalid_attributes}, session: valid_session
        expect(response).to redirect_to("/user_holders/"+ @user.user_holder.id.to_s + "/treatments")
      end
    end
  end

  describe "POST #create - Doctor" do
    fixtures :users
    fixtures :treatments
    context "with valid params" do
      it "creates a new Treatment" do
        @user = users(:doctor_)
        @patient = users(:patient_)
        UserHolder.create!(first_name: @patient.first_name, last_name: @patient.last_name, email: @patient.email, user_id: @patient.id)
        attributes = { "provider" => "provider1",
            "name" => "name1",
            "location" => "location1",
            "status" => "status1",
            "description" => "description1",
            "user_holder_id" => @patient.user_holder.id,
          }

        Profile.create!(first_name: @patient.first_name, last_name: @patient.last_name, email: @patient.email, whatsapp: '6198089569', user_holder_id: @patient.user_holder.id)
        sign_in @user
        UserHolder.create!(first_name: @user.first_name, last_name: @user.last_name, email: @user.email, user_id: @user.id)
        expect {
          post :create, params: {"user_holder_id" => @patient.user_holder.id, treatment: attributes}, session: valid_session
        }.to change(Treatment, :count).by(1)
      end
    end

    context "with invalid params" do
      it "creates a new Treatment" do
        @user = users(:doctor_)
        @patient = users(:patient_)
        UserHolder.create!(first_name: @patient.first_name, last_name: @patient.last_name, email: @patient.email, user_id: @patient.id)
        Profile.create!(first_name: @patient.first_name, last_name: @patient.last_name, email: @patient.email, whatsapp: '6198089569', user_holder_id: @patient.user_holder.id)
        sign_in @user
        UserHolder.create!(first_name: @user.first_name, last_name: @user.last_name, email: @user.email, user_id: @user.id)
        expect {
          post :create, params: {"user_holder_id" => @patient.user_holder.id, treatment: invalid_attributes}, session: valid_session
        }.to raise_error(ActionController::ParameterMissing)
      end
    end
  end


  describe "PUT #update - Patient" do
    fixtures :users
    fixtures :treatments

    context "with valid params" do
      it "updates the requested treatment" do
        @user = users(:patient_)
        sign_in @user
        UserHolder.create!(first_name: @user.first_name, last_name: @user.last_name, email: @user.email, user_id: @user.id)
        attributes = { "provider" => "provider1",
            "name" => "name1",
            "location" => "location1",
            "status" => "status1",
            "description" => "description1",
            "user_holder_id" => @user.user_holder.id,
          }
        treatment = Treatment.create!(attributes)
        attributes2 = { "provider" => "provider2",
            "name" => "name2",
            "location" => "location2",
            "status" => "status2",
            "description" => "description2",
            "user_holder_id" => @user.user_holder.id,
          }
        put :update, params: {"id" => treatment.id ,"user_holder_id" => @user.user_holder.id, treatment: attributes2}, session: valid_session
        expect(response).to redirect_to("/user_holders/"+ @user.user_holder.id.to_s + "/treatments")
      end
    end

  end

  describe "PUT #update - Doctor" do
    fixtures :users
    fixtures :treatments
    context "with valid params" do
      it "updates the requested treatment" do
        @user = users(:doctor_)
        sign_in @user
        UserHolder.create!(first_name: @user.first_name, last_name: @user.last_name, email: @user.email, user_id: @user.id)
        @patient = users(:patient_)
        UserHolder.create!(first_name: @patient.first_name, last_name: @patient.last_name, email: @patient.email, user_id: @patient.id)
        attributes = { "provider" => "provider1",
            "name" => "name1",
            "location" => "location1",
            "status" => "status1",
            "description" => "description1",
            "user_holder_id" => @patient.user_holder.id,
          }
        Profile.create!(first_name: @patient.first_name, last_name: @patient.last_name, email: @patient.email, whatsapp: '6198089569', user_holder_id: @patient.user_holder.id)
        treatment = Treatment.create!(attributes)
        attributes2 = { "provider" => "provider2",
            "name" => "name2",
            "location" => "location2",
            "status" => "status2",
            "description" => "description2",
            "user_holder_id" => @patient.user_holder.id,
          }
        put :update, params: {"id" => treatment.id ,"user_holder_id" => @patient.user_holder.id, treatment: attributes2}, session: valid_session
        treatment.reload
        expect(treatment.name).to eq("name2")
      end
    end
  end

  describe "DELETE #destroy - Patient" do
    fixtures :users
    fixtures :treatments

    it "destroys the requested treatment" do
      @user = users(:doctor_)
      sign_in @user
      UserHolder.create!(first_name: @user.first_name, last_name: @user.last_name, email: @user.email, user_id: @user.id)
      @patient = users(:patient_)
      UserHolder.create!(first_name: @patient.first_name, last_name: @patient.last_name, email: @patient.email, user_id: @patient.id)
      attributes = { "provider" => "provider1",
          "name" => "name1",
          "location" => "location1",
          "status" => "status1",
          "description" => "description1",
          "user_holder_id" => @patient.user_holder.id,
        }
      Profile.create!(first_name: @patient.first_name, last_name: @patient.last_name, email: @patient.email, whatsapp: '6198089569', user_holder_id: @patient.user_holder.id)
      treatment = Treatment.create!(attributes)

      @user = users(:patient_)
      sign_in @user
      UserHolder.create!(first_name: @user.first_name, last_name: @user.last_name, email: @user.email, user_id: @user.id)
      delete :destroy, params: {"id" => treatment.id ,"user_holder_id" => @patient.user_holder.id}, session: valid_session
      expect(response).to redirect_to("/user_holders/"+ @user.user_holder.id.to_s + "/treatments")
    end
  end


  describe "DELETE #destroy - Doctor" do
    fixtures :users
    context "with valid params" do
      it "updates the requested treatment" do
        @user = users(:doctor_)
        sign_in @user
        UserHolder.create!(first_name: @user.first_name, last_name: @user.last_name, email: @user.email, user_id: @user.id)
        @patient = users(:patient_)
        UserHolder.create!(first_name: @patient.first_name, last_name: @patient.last_name, email: @patient.email, user_id: @patient.id)
        attributes = { "provider" => "provider1",
            "name" => "name1",
            "location" => "location1",
            "status" => "status1",
            "description" => "description1",
            "user_holder_id" => @patient.user_holder.id,
          }
        Profile.create!(first_name: @patient.first_name, last_name: @patient.last_name, email: @patient.email, whatsapp: '6198089569', user_holder_id: @patient.user_holder.id)
        treatment = Treatment.create!(attributes)
        expect {
          delete :destroy, params: {"id" => treatment.id ,"user_holder_id" => @patient.user_holder.id}, session: valid_session
        }.to change(Treatment, :count).by(-1)
      end
    end
  end

end
