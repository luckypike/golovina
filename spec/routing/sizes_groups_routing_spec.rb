require "rails_helper"

RSpec.describe SizesGroupsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/sizes_groups").to route_to("sizes_groups#index")
    end

    it "routes to #new" do
      expect(:get => "/sizes_groups/new").to route_to("sizes_groups#new")
    end

    it "routes to #show" do
      expect(:get => "/sizes_groups/1").to route_to("sizes_groups#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/sizes_groups/1/edit").to route_to("sizes_groups#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/sizes_groups").to route_to("sizes_groups#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/sizes_groups/1").to route_to("sizes_groups#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/sizes_groups/1").to route_to("sizes_groups#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/sizes_groups/1").to route_to("sizes_groups#destroy", :id => "1")
    end

  end
end
