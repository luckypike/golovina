require 'rails_helper'

RSpec.describe "Looks", type: :request do
  describe "GET /looks" do
    it "works! (now write some real specs)" do
      get looks_path
      expect(response).to have_http_status(200)
    end
  end
end
