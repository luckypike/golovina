# frozen_string_literal: true

RSpec.describe Carts::CheckoutCmd, :aggregate_failures do
  subject(:cmd) { described_class.call(order: order, checkout_params: checkout_params) }

  let(:user) { create(:api_user) }

  describe '#call' do
    context 'when order is correct and valid params' do
      let(:order) { create(:api_order, :cart, user: user) }
      let(:checkout_params) { {} }

      it do
        expect { cmd }.to raise_error(ServiceActor::Failure)
      end
    end
  end
end
