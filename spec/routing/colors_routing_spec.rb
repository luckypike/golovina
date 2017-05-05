require "rails_helper"

RSpec.describe ColorsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/colors").to route_to("colors#index")
    end

    it "routes to #new" do
      expect(:get => "/colors/new").to route_to("colors#new")
    end

    it "routes to #show" do
      expect(:get => "/colors/1").to route_to("colors#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/colors/1/edit").to route_to("colors#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/colors").to route_to("colors#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/colors/1").to route_to("colors#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/colors/1").to route_to("colors#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/colors/1").to route_to("colors#destroy", :id => "1")
    end

  end
end
