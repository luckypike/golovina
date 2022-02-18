# frozen_string_literal: true

RSpec.describe Api::CartsController do
  describe '#show' do
    let(:params) { { format: :json } }
    subject { post :show, params: params }

    before { allow(Carts::ShowCmd).to receive(:call).and_return(true) }

    context 'with guest user' do
      let(:user) { create(:user, :guest) }
      before { sign_in(user) }

      it do
        expect(subject).to have_http_status(:ok)
        expect(Carts::ShowCmd).to have_received(:call)
      end
    end

    context 'with common user' do
      let(:user) { create(:user) }
      before { sign_in(user) }

      it do
        expect(subject).to have_http_status(:ok)
        expect(Carts::ShowCmd).to have_received(:call)
      end
    end

    context 'without user' do
      it do
        expect(subject).to have_http_status(:unauthorized)
        expect(Carts::ShowCmd).not_to have_received(:call)
      end

    end
  end
end
