# frozen_string_literal: true

RSpec.describe Sessions::SetJwtSessionCmd, :aggregate_failures do
  subject(:cmd) { described_class.call(user: user) }

  describe "create valid jwt" do
    let(:user) { create(:api_user) }

    it do
      expect(cmd).to be_success
      expect(
        JWT.decode(cmd.token, OpenSSL::PKey::RSA.new(Figaro.env.auth_public_key), true, { algorithm: "RS256" }).first
      ).to include({ sub: user.id }.stringify_keys)
    end
  end
end
