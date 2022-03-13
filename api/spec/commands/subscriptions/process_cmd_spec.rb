# frozen_string_literal: true

RSpec.describe Subscriptions::ProcessCmd, :aggregate_failures do
  subject(:cmd) { described_class.call(subscription: subscription) }

  let(:subscription) { create(:subscription) }

  describe '#call' do
    before do
      stub_request(:get, 'https://api.unisender.com/ru/api/subscribe')
        .with(query: hash_including({}))
    end

    it do
      cmd

      expect(subscription.reload).to be_active
    end
  end
end
