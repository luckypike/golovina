require "rails_helper"

RSpec.describe SizesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/sizes").to route_to("sizes#index")
    end

    it "routes to #new" do
      expect(:get => "/sizes/new").to route_to("sizes#new")
    end

    it "routes to #show" do
      expect(:get => "/sizes/1").to route_to("sizes#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/sizes/1/edit").to route_to("sizes#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/sizes").to route_to("sizes#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/sizes/1").to route_to("sizes#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/sizes/1").to route_to("sizes#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/sizes/1").to route_to("sizes#destroy", :id => "1")
    end

  end
end
