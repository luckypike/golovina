# frozen_string_literal: true

RSpec.describe Sessions::SendCodeJob, :aggregate_failures do
  describe "#perform" do
    subject(:cmd) { described_class.perform_now(user: user) }

    let(:user) { build(:api_user) }

    before do
      allow(Users::SendCodeBySmsCmd).to receive(:call).and_return(true)
    end

    it do
      cmd

      expect(Users::SendCodeBySmsCmd).to have_received(:call).with(user: user)
    end
  end
end
