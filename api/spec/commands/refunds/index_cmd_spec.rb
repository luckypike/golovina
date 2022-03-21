# frozen_string_literal: true

RSpec.describe Refunds::IndexCmd, :aggregate_failures do
  subject(:cmd) { described_class.call(user: user) }

  let(:order) { create(:api_order) }
  let(:user) { order.user }

  describe "#call" do
    context "with valid params" do
      it { is_expected.to be_success }

      it do
        expect(cmd.orders.map(&:id)).to match([order.id])
      end
    end
  end
end
