# frozen_string_literal: true

RSpec.describe SubscriptionProcessJob, :aggregate_failures do
  describe "#perform" do
    subject(:cmd) { described_class.perform_now(subscription: subscription) }

    let(:subscription) { build(:subscription) }

    before do
      allow(Subscriptions::ProcessCmd).to receive(:call).and_return(true)
    end

    it do
      cmd

      expect(Subscriptions::ProcessCmd).to have_received(:call).with(subscription: subscription)
    end
  end
end
