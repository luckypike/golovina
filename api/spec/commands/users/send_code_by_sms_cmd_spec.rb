# frozen_string_literal: true

RSpec.describe Users::SendCodeBySmsCmd, :aggregate_failures do
  subject(:cmd) { described_class.call(user: user) }

  describe "#call" do
    context "when user exists" do
      let(:user) { create(:api_user, phone: "+79999999999", phone_code: "1234") }

      before do
        stub_request(:post, "https://gate.smsaero.ru/v2/sms/testsend")
          .with(
            body: include_json(
              {
                number: user.phone,
                text: "Golovina Mari: 1234"
              }
            )
          )
      end

      it do
        expect(cmd).to be_success
      end
    end
  end
end
