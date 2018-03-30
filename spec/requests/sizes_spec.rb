require 'rails_helper'

RSpec.describe "Sizes", type: :request do
  describe "GET /sizes" do
    it "works! (now write some real specs)" do
      get sizes_path
      expect(response).to have_http_status(200)
    end
  end
end
