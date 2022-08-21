# frozen_string_literal: true

RSpec.describe Api::Account::RefundsController, :aggregate_failures do
  describe "#create" do
    subject(:cmd) { post :create, params: params }

    let(:params) { { format: :json } }

    before { allow(Refunds::CreateCmd).to receive(:call).and_return(true) }

    context "when user have not access" do
      it do
        expect(cmd).to have_http_status(:unauthorized)
        expect(Refunds::CreateCmd).not_to have_received(:call)
      end
    end

    context "when user have access" do
      let(:user) { create(:user) }

      before { cookies[:_golovina_jwt] = generate_test_jwt(user.id) }

      it do
        expect(cmd).to have_http_status(:ok)
        expect(Refunds::CreateCmd).to have_received(:call)
          .with(user: Api::User.find(user.id), refund_params: instance_of(ActionController::Parameters))
      end
    end
  end

  describe "#new" do
    subject(:cmd) { get :new, params: { format: :json } }

    before { allow(Refunds::IndexCmd).to receive(:call).and_return(true) }

    context "when user have not access" do
      it do
        expect(cmd).to have_http_status(:unauthorized)
        expect(Refunds::IndexCmd).not_to have_received(:call)
      end
    end

    context "when user have access" do
      let(:user) { create(:user) }

      before { cookies[:_golovina_jwt] = generate_test_jwt(user.id) }

      it do
        expect(cmd).to have_http_status(:ok)
        expect(Refunds::IndexCmd).to have_received(:call)
      end
    end
  end
end
