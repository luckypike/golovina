require 'rails_helper'

RSpec.describe "Kits", type: :request do
  describe "GET /kits" do
    it "works! (now write some real specs)" do
      get kits_path
      expect(response).to have_http_status(200)
    end
  end
end
