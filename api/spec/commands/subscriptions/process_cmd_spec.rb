# frozen_string_literal: true

RSpec.describe Subscriptions::ProcessCmd, :aggregate_failures do
  subject { described_class.call(subscription: subscription) }
  let(:subscription) { create(:subscription) }

  describe '#call' do
    it do
      subject

      expect(subscription.reload.active?).to be_truthy
    end
  end
end
