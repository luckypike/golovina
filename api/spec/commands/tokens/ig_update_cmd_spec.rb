# frozen_string_literal: true

RSpec.describe Tokens::IgUpdateCmd, :aggregate_failures do
  subject(:cmd) { described_class.call(token: token) }

  let(:token) { create(:token, key: :instagram) }
  let(:access_token) { Random.hex }

  describe "#call" do
    context "when IG returns 200" do
      before do
        stub_request(
          :get,
          "https://graph.instagram.com/refresh_access_token?access_token=#{token.value}&grant_type=ig_refresh_token"
        ).to_return(
          status: 200,
          body: { access_token: access_token, expires_in: 5_103_278, token_type: "bearer" }.to_json,
          headers: { content_type: "application/json" }
        )
      end

      it do
        cmd

        expect(token.reload.value).to eq access_token
      end
    end

    context "when IG returns errors" do
      before do
        stub_request(
          :get,
          "https://graph.instagram.com/refresh_access_token?access_token=#{token.value}&grant_type=ig_refresh_token"
        ).to_return(
          status: 400,
          body: "Sorry, this content isn't available right now"
        )
      end

      it do
        expect { cmd }.to raise_error(StandardError)
      end
    end
  end
end
