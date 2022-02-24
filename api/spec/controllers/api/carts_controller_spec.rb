# frozen_string_literal: true

RSpec.describe Api::CartsController, :aggregate_failures do
  describe '#show' do
    subject(:cmd) { post :show, params: params }

    let(:params) { { format: :json } }

    before { allow(Carts::ShowCmd).to receive(:call).and_return(true) }

    context 'with guest user' do
      let(:user) { create(:user, :guest) }

      before { sign_in(user) }

      it do
        expect(cmd).to have_http_status(:ok)
        expect(Carts::ShowCmd).to have_received(:call)
      end
    end

    context 'with common user' do
      let(:user) { create(:user) }

      before { sign_in(user) }

      it do
        expect(cmd).to have_http_status(:ok)
        expect(Carts::ShowCmd).to have_received(:call)
      end
    end

    context 'without user' do
      it do
        expect(cmd).to have_http_status(:unauthorized)
        expect(Carts::ShowCmd).not_to have_received(:call)
      end
    end
  end

  describe 'POST #apply_promo_code' do
    subject(:cmd) { post :apply_promo_code, params: params }

    let(:params) { { format: :json } }

    before { allow(Carts::PromoCodes::ApplyCmd).to receive(:call).and_return(true) }

    context 'with user' do
      let(:user) { create(:user) }

      before { sign_in(user) }

      it do
        expect(cmd).to have_http_status(:no_content)
        expect(Carts::PromoCodes::ApplyCmd).to have_received(:call)
      end
    end

    context 'without user' do
      it do
        expect(cmd).to have_http_status(:unauthorized)
        expect(Carts::PromoCodes::ApplyCmd).not_to have_received(:call)
      end
    end
  end

  describe 'POST #delete_promo_code' do
    subject(:cmd) { post :delete_promo_code, params: params }

    let(:params) { { format: :json } }

    before { allow(Carts::PromoCodes::DeleteCmd).to receive(:call).and_return(true) }

    context 'with user' do
      let(:user) { create(:user) }

      before { sign_in(user) }

      it do
        expect(cmd).to have_http_status(:no_content)
        expect(Carts::PromoCodes::DeleteCmd).to have_received(:call)
      end
    end

    context 'without user' do
      it do
        expect(cmd).to have_http_status(:unauthorized)
        expect(Carts::PromoCodes::DeleteCmd).not_to have_received(:call)
      end
    end
  end

  describe 'POST #checkout' do
    subject(:cmd) { post :checkout, params: params }

    let(:params) { { format: :json } }

    before { allow(Carts::CheckoutCmd).to receive(:call).and_return(true) }

    context 'with user' do
      let(:user) { create(:user) }

      before do
        sign_in(user)
        create(:api_order, :cart, user: user)
      end

      it do
        expect(cmd).to have_http_status(:no_content)
        expect(Carts::CheckoutCmd).to have_received(:call)
      end
    end

    context 'without user' do
      it do
        expect(cmd).to have_http_status(:unauthorized)
        expect(Carts::CheckoutCmd).not_to have_received(:call)
      end
    end
  end

  describe 'POST #delivery' do
    subject(:cmd) { post :delivery, params: params }

    let(:params) { { format: :json } }

    before { allow(Carts::DeliveryCmd).to receive(:call).and_return(true) }

    context 'with user' do
      let(:user) { create(:user) }

      before do
        sign_in(user)
        create(:api_order, :cart, user: user)
      end

      it do
        expect(cmd).to have_http_status(:no_content)
        expect(Carts::DeliveryCmd).to have_received(:call)
      end
    end

    context 'without user' do
      it do
        expect(cmd).to have_http_status(:unauthorized)
        expect(Carts::DeliveryCmd).not_to have_received(:call)
      end
    end
  end
end
