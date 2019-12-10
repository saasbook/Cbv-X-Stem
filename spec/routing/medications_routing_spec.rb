require "rails_helper"

RSpec.describe MedicationsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/user_holders/1/medications").to route_to(
        :controller => "medications",
        :action => "index",
        :user_holder_id => "1"
      )
    end
#
    it "routes to #new" do
      expect(:get => "/user_holders/1/medications/new").to route_to(
        :controller => "medications",
        :action => "new",
        :user_holder_id => "1"
      )
    end

    it "routes to #show" do
      expect(:get => "/user_holders/1/medications/1").to route_to(
        :controller => "medications",
        :action => "show",
        :user_holder_id => "1",
        :id => "1",
      )
    end

    it "routes to #edit" do
      expect(:get => "/user_holders/1/medications/1/edit").to route_to(
        :controller => "medications",
        :action => "edit",
        :user_holder_id => "1",
        :id => "1",
      )
    end

#
    it "routes to #create" do
      expect(:post => "/user_holders/1/medications").to route_to(
        :controller => "medications",
        :action => "create",
        :user_holder_id => "1",
      )
    end
#
    it "routes to #update via PUT" do
      expect(:put => "/user_holders/1/medications/1").to route_to(
        :controller => "medications",
        :action => "update",
        :user_holder_id => "1",
        :id => "1",
      )
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/user_holders/1/medications/1").to route_to(
        :controller => "medications",
        :action => "update",
        :user_holder_id => "1",
        :id => "1",
      )
    end

    it "routes to #destroy" do
      expect(:delete => "/user_holders/1/medications/1").to route_to(
        :controller => "medications",
        :action => "destroy",
        :user_holder_id => "1",
        :id => "1",
      )
    end
  end
end
