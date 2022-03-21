# frozen_string_literal: true

RSpec.describe Api::SubscriptionsController, :aggregate_failures do
  describe "#create" do
    subject(:cmd) { post :create, params: params }

    let(:params) { { format: :json } }

    before { allow(Subscriptions::CreateCmd).to receive(:call).and_return(true) }

    it do
      expect(cmd).to have_http_status(:no_content)
      expect(Subscriptions::CreateCmd).to have_received(:call)
        .with(subscription_params: instance_of(ActionController::Parameters))
    end
  end
end
