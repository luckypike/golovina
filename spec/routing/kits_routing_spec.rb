require "rails_helper"

RSpec.describe KitsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/kits").to route_to("kits#index")
    end

    it "routes to #new" do
      expect(:get => "/kits/new").to route_to("kits#new")
    end

    it "routes to #show" do
      expect(:get => "/kits/1").to route_to("kits#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/kits/1/edit").to route_to("kits#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/kits").to route_to("kits#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/kits/1").to route_to("kits#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/kits/1").to route_to("kits#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/kits/1").to route_to("kits#destroy", :id => "1")
    end

  end
end
