require "rails_helper"

RSpec.describe LooksController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/looks").to route_to("looks#index")
    end

    it "routes to #new" do
      expect(:get => "/looks/new").to route_to("looks#new")
    end

    it "routes to #show" do
      expect(:get => "/looks/1").to route_to("looks#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/looks/1/edit").to route_to("looks#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/looks").to route_to("looks#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/looks/1").to route_to("looks#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/looks/1").to route_to("looks#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/looks/1").to route_to("looks#destroy", :id => "1")
    end

  end
end
