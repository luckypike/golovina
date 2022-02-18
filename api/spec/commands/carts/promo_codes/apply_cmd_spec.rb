# frozen_string_literal: true

RSpec.describe Carts::PromoCodes::ApplyCmd, :aggregate_failures do
  subject(:cmd) { described_class.call(user: user, promo_code_params: params) }

  let(:user) { create(:api_user) }
  let(:params) { nil }
  let!(:order) { create(:api_order, :cart, user: user) }

  describe '#call' do
    context 'when promo_code is valid' do
      let(:promo_code) { create(:promo_code) }
      let(:params) { { title: promo_code.title } }

      it do
        expect(cmd).to be_success
        expect(order.reload.promo_code_id).to eq(promo_code.id)
      end
    end

    context 'when promo_code is inactive' do
      let(:promo_code) { create(:promo_code, state: :inactive) }
      let(:params) { { title: promo_code.title } }

      it { expect { cmd }.to raise_error(ActiveRecord::RecordNotFound) }
    end

    context 'without order' do
      let(:another_user) { create(:api_user) }
      let(:promo_code) { create(:promo_code, state: :inactive) }
      let(:params) { { title: promo_code.title } }

      before { Api::Order.destroy_all }

      it { expect { cmd }.to raise_error(ActiveRecord::RecordNotFound) }
    end

    context 'without promo code' do
      it { expect { cmd }.to raise_error(ServiceActor::Failure) }
    end

    context 'with nil params' do
      let(:params) { nil }

      it { expect { cmd }.to raise_error(ServiceActor::Failure) }
    end
  end
end
