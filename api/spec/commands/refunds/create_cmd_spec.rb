# frozen_string_literal: true

RSpec.describe Refunds::CreateCmd, :aggregate_failures do
  subject(:cmd) { described_class.call(refund_params: params, user: user) }

  let(:order) { create(:api_order) }
  let(:order_item) { create(:api_order_item, order: order) }
  let(:user) { order.user }

  describe "#call" do
    context "with valid params" do
      let(:params) do
        {
          order_id: order.id,
          reason: "size",
          order_item_ids: [order_item.id]
        }
      end

      it { is_expected.to be_success }

      it do
        expect { cmd }
          .to change { Api::Refund.state_active.all.size }.by(1)
          .and change { Api::RefundOrderItem.all.size }.by(1)
      end

      context "with partially returned items" do
        let(:refund) { create(:refund, user: user) }

        before do
          create(:refund_order_item, refund: refund, order_item: order_item)
          create(:api_order_item, order: order)
        end

        it do
          expect { cmd }
            .to raise_error(ServiceActor::Failure)
            .and(not_change { Api::Refund.state_active.all.size })
            .and(not_change { Api::RefundOrderItem.all.size })
        end
      end
    end
  end
end
