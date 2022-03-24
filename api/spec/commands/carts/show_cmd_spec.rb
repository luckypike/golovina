# frozen_string_literal: true

RSpec.describe Carts::ShowCmd, :aggregate_failures do
  subject(:cmd) { described_class.call(user: user) }

  let(:user) { create(:api_user) }
  let(:order) { create(:api_order, :cart, user: user) }

  describe "#call" do
    context "when cart containt inactive variant" do
      let(:variant_unpub) { create(:variant, state: :unpub) }
      let(:variant_archived) { create(:variant, state: :archived) }

      before do
        create(:api_order_item, order: order)
        create(:api_order_item, order: order, variant: variant_unpub)
        create(:api_order_item, order: order, variant: variant_archived)
      end

      it { is_expected.to be_success }

      it do
        expect { cmd }.to change { Api::OrderItem.where(order: order).all.size }.by(-2)
      end
    end
  end
end
