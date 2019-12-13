require "rails_helper"

RSpec.describe TreatmentsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/user_holders/1/treatments").to route_to(
        :controller => "treatments",
        :action => "index",
        :user_holder_id => "1"
      )
    end
#
    it "routes to #new" do
      expect(:get => "/user_holders/1/treatments/new").to route_to(
        :controller => "treatments",
        :action => "new",
        :user_holder_id => "1"
      )
    end

    it "routes to #show" do
      expect(:get => "/user_holders/1/treatments/1").to route_to(
        :controller => "treatments",
        :action => "show",
        :user_holder_id => "1",
        :id => "1",
      )
    end

    it "routes to #edit" do
      expect(:get => "/user_holders/1/treatments/1/edit").to route_to(
        :controller => "treatments",
        :action => "edit",
        :user_holder_id => "1",
        :id => "1",
      )
    end

#
    it "routes to #create" do
      expect(:post => "/user_holders/1/treatments").to route_to(
        :controller => "treatments",
        :action => "create",
        :user_holder_id => "1",
      )
    end
#
    it "routes to #update via PUT" do
      expect(:put => "/user_holders/1/treatments/1").to route_to(
        :controller => "treatments",
        :action => "update",
        :user_holder_id => "1",
        :id => "1",
      )
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/user_holders/1/treatments/1").to route_to(
        :controller => "treatments",
        :action => "update",
        :user_holder_id => "1",
        :id => "1",
      )
    end

    it "routes to #destroy" do
      expect(:delete => "/user_holders/1/treatments/1").to route_to(
        :controller => "treatments",
        :action => "destroy",
        :user_holder_id => "1",
        :id => "1",
      )
    end
  end
end
