require 'rails_helper'

RSpec.describe "SizesGroups", type: :request do
  describe "GET /sizes_groups" do
    it "works! (now write some real specs)" do
      get sizes_groups_path
      expect(response).to have_http_status(200)
    end
  end
end
