# frozen_string_literal: true

RSpec.describe Sessions::SendCodeBySmsCmd, :aggregate_failures do
  subject(:cmd) { described_class.call(code_params: code_params) }

  describe "#call" do
    context "when user exists" do
      let!(:user) { create(:api_user, phone: "+79999999999", phone_code: nil) }
      let(:code_params) { { phone: "+7 (999) 999 99-99" } }

      it do
        expect(cmd).to be_success
        expect(user.reload.phone_code).to eq("1111")
      end

      it { expect { cmd }.to have_enqueued_job(Sessions::SendCodeJob) }
    end

    context "when cmd calls second time" do
      let!(:user) { create(:api_user, phone: "+79999999999", phone_code: "9999") }
      let(:code_params) { { phone: "+7 (999) 999 99-99" } }

      it do
        expect(cmd).to be_success
        expect(user.reload.phone_code).to eq("9999")
      end

      it { expect { cmd }.to have_enqueued_job(Sessions::SendCodeJob) }
    end

    context "when user does not exists" do
      let(:code_params) { { phone: "+7 (999) 999 99-88" } }

      before { create(:api_user, phone: "+79999999999") }

      it { expect { cmd }.to raise_error(ActiveRecord::RecordNotFound) }
    end
  end
end
