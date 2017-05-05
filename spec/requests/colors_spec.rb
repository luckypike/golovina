require 'rails_helper'

RSpec.describe "Colors", type: :request do
  describe "GET /colors" do
    it "works! (now write some real specs)" do
      get colors_path
      expect(response).to have_http_status(200)
    end
  end
end
