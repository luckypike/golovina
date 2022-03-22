# frozen_string_literal: true

RSpec.describe Refunds::IndexCmd, :aggregate_failures do
  subject(:cmd) { described_class.call(user: user) }

  let(:order) { create(:api_order) }
  let(:user) { order.user }

  before do
    create(:api_order_item, order: order)
  end

  describe "#call" do
    context "with valid params" do
      it do
        expect(cmd).to be_success
        expect(cmd.orders.map(&:id)).to match([order.id])
      end
    end
  end
end
