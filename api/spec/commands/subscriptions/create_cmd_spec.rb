# frozen_string_literal: true

RSpec.describe Subscriptions::CreateCmd, :aggregate_failures do
  subject { described_class.call(subscription_params: params) }

  describe '#call' do
    context 'with valid params' do
      let(:params) do
        {
          email: 'user@example.com',
          first_name: 'Beth',
          last_name: 'Smith',
          date_of_birth: Time.current.to_date
        }
      end

      it do
        should be_success

        expected_subscription = Subscription.find_by!(email: params[:email])
        expect(expected_subscription.first_name).to eq(params[:first_name])
        expect(expected_subscription.last_name).to eq(params[:last_name])
        expect(expected_subscription.date_of_birth).to eq(params[:date_of_birth])
      end

      it { expect { subject }.to change { Subscription.all.size }.by(1) }
      it { expect { subject }.to have_enqueued_job(SubscriptionProcessJob) }
    end
  end
end
