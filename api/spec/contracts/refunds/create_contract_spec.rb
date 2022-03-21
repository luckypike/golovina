# frozen_string_literal: true

RSpec.describe Refunds::CreateContract, :aggregate_failures do
  subject(:contract) { described_class.new.call(refund_params) }

  describe "#call" do
    context "without params" do
      let(:refund_params) { {} }

      it { is_expected.to be_failure }
      it { expect(contract.errors.to_h.keys).to match(%i[order_id reason order_item_ids]) }
    end

    context "with empty order_item_ids" do
      let(:refund_params) { { order_item_ids: [] } }

      it { is_expected.to be_failure }
      it { expect(contract.errors.to_h.keys).to include(:order_item_ids) }
    end

    context "with valid params" do
      let(:order_item) { create(:api_order_item) }
      let(:refund_params) do
        {
          order_id: order_item.order.id,
          reason: "size",
          order_item_ids: [order_item.id]
        }
      end

      it { is_expected.to be_success }
    end

    context "without detail with other" do
      let(:order_item) { create(:api_order_item) }
      let(:refund_params) do
        {
          order_id: order_item.order.id,
          reason: "other",
          order_item_ids: [order_item.id]
        }
      end

      it { is_expected.to be_failure }
      it { expect(contract.errors.to_h.keys).to include(:detail) }
    end
  end
end
