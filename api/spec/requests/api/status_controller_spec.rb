# frozen_string_literal: true

RSpec.describe Api::StatusController, type: :request do
  describe 'GET index' do
    before do
      get '/api/status'
    end

    it { expect(response).to have_http_status :ok }
  end
end
