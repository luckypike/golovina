# frozen_string_literal: true

RSpec.describe Subscriptions::ProcessCmd, :aggregate_failures do
  subject { described_class.call(subscription: subscription) }
  let(:subscription) { create(:subscription) }

  describe '#call' do
    before do
      stub_request(:get, "https://api.unisender.com/ru/api/subscribe")
        .with(query: hash_including({}))

      allow(UnisenderClient).to receive(:subscribe).and_return(true)
    end

    it do
      subject

      expect(subscription.reload.active?).to be_truthy
      expect(UnisenderClient).to have_received(:subscribe)
    end
  end
end
