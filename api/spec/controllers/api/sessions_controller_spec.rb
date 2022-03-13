# frozen_string_literal: true

RSpec.describe Api::SessionsController do
  describe '#apple' do
    subject(:cmd) { post :apple, params: params }

    let(:user) { create(:user) }
    let(:sign_in_with_apple_cmd) { instance_double('SignInWithAppleIdCmd', { user: user }) }

    before { allow(Sessions::SignInWithAppleIdCmd).to receive(:call).and_return(sign_in_with_apple_cmd) }

    context 'when user auth first time' do
      let(:user_params) { { name: { firstName: 'F', lastName: 'L' } } }
      let(:id_token) { { sub: SecureRandom.uuid } }
      let(:params) do
        {
          user: user_params.to_json,
          id_token: JWT.encode(id_token, nil, 'none')
        }
      end

      it { expect(cmd).to have_http_status(:found) }
      it { expect(cmd).to redirect_to('/') }

      it do
        cmd

        expect(Sessions::SignInWithAppleIdCmd).to have_received(:call)
          .with(token_params: id_token.stringify_keys, referer: nil, user_params: user_params, current_user: nil)
      end
    end

    context 'when redirec_to exists' do
      let(:params) { { return_uri: '/cart' } }

      it { expect(cmd).to have_http_status(:found) }
      it { expect(cmd).to redirect_to('/cart#checkout') }
    end

    context 'when user auth second time' do
      let(:id_token) { { sub: SecureRandom.uuid } }
      let(:params) { { id_token: JWT.encode(id_token, nil, 'none') } }

      it do
        cmd

        expect(Sessions::SignInWithAppleIdCmd).to have_received(:call)
          .with(token_params: id_token.stringify_keys, referer: nil, user_params: nil, current_user: nil)
      end
    end

    context 'when token is invalid' do
      let(:params) { { id_token: 'invalid_token' } }

      it do
        cmd

        expect(Sessions::SignInWithAppleIdCmd).to have_received(:call)
          .with(token_params: nil, referer: nil, user_params: nil, current_user: nil)
      end
    end
  end
end
