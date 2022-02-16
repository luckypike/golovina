# frozen_string_literal: true

RSpec.describe Api::SubscriptionsController do
  describe '#create' do
    let(:params) { { format: :json } }
    subject { post :create, params: params }
    before { allow(Subscriptions::CreateCmd).to receive(:call).and_return(true) }

    it do
      expect(subject).to have_http_status(:no_content)
      expect(Subscriptions::CreateCmd).to have_received(:call)
        .with(subscription_params: instance_of(ActionController::Parameters))
    end
  end
end
