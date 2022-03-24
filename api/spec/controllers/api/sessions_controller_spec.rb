# frozen_string_literal: true

RSpec.describe Api::SessionsController, :aggregate_failures do
  describe "#apple" do
    subject(:cmd) { post :apple, params: params }

    let(:user) { create(:user) }
    let(:sign_in_with_apple_cmd) { instance_double("SignInWithAppleIdCmd", { user: user }) }

    before { allow(Sessions::SignInWithAppleIdCmd).to receive(:call).and_return(sign_in_with_apple_cmd) }

    context "when user auth first time" do
      let(:user_params) { { name: { firstName: "F", lastName: "L" } } }
      let(:id_token) { { sub: SecureRandom.uuid } }
      let(:params) do
        {
          user: user_params.to_json,
          id_token: JWT.encode(id_token, nil, "none")
        }
      end

      it { expect(cmd).to have_http_status(:found) }
      it { expect(cmd).to redirect_to("/") }

      it do
        cmd

        expect(Sessions::SignInWithAppleIdCmd).to have_received(:call)
          .with(token_params: id_token.stringify_keys, referer: nil, user_params: user_params, current_user: nil)
      end
    end

    context "when redirec_to exists" do
      let(:params) { { return_uri: "/cart" } }

      it { expect(cmd).to have_http_status(:found) }
      it { expect(cmd).to redirect_to("/cart#checkout") }
    end

    context "when user auth second time" do
      let(:id_token) { { sub: SecureRandom.uuid } }
      let(:params) { { id_token: JWT.encode(id_token, nil, "none") } }

      it do
        cmd

        expect(Sessions::SignInWithAppleIdCmd).to have_received(:call)
          .with(token_params: id_token.stringify_keys, referer: nil, user_params: nil, current_user: nil)
      end
    end

    context "when token is invalid" do
      let(:params) { { id_token: "invalid_token" } }

      it do
        cmd

        expect(Sessions::SignInWithAppleIdCmd).to have_received(:call)
          .with(token_params: nil, referer: nil, user_params: nil, current_user: nil)
      end
    end
  end

  describe "#code" do
    subject(:cmd) { post :code, params: params }

    context "with correct phone" do
      let(:send_code_by_sms_cmd) { instance_double("SendCodeBySmsCmd") }
      let(:params) { { phone: "+79999999999" } }

      before { allow(Sessions::SendCodeBySmsCmd).to receive(:call).and_return(send_code_by_sms_cmd) }

      it do
        expect(cmd).to have_http_status(:no_content)
        expect(Sessions::SendCodeBySmsCmd).to have_received(:call)
          .with(code_params: instance_of(ActionController::Parameters))
      end
    end

    context "with wrong phone" do
      let(:params) { { phone: "WRONG" } }

      before { allow(Sessions::SendCodeBySmsCmd).to receive(:call).and_call_original }

      it do
        expect(cmd).to have_http_status(:unprocessable_entity)
        expect(Sessions::SendCodeBySmsCmd).to have_received(:call)
      end
    end
  end
end
