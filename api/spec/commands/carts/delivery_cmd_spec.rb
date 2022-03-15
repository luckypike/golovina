# frozen_string_literal: true

RSpec.describe Carts::DeliveryCmd, :aggregate_failures do
  subject(:cmd) { described_class.call(order: order, delivery_params: delivery_params) }

  let(:user) { create(:api_user) }

  describe "#call" do
    context "when order is correct and valid params" do
      let(:order) { create(:api_order, :cart, user: user) }
      let(:delivery_params) { {} }

      it do
        expect { cmd }.to raise_error(ServiceActor::Failure)
      end
    end
  end
end
