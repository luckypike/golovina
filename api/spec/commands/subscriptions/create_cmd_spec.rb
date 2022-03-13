# frozen_string_literal: true

RSpec.describe Subscriptions::CreateCmd, :aggregate_failures do
  subject(:cmd) { described_class.call(subscription_params: params) }

  describe '#call' do
    context 'with valid params' do
      let(:email) { 'user@example.com' }
      let(:params) do
        {
          email: "#{email.upcase} ",
          first_name: 'Beth',
          last_name: 'Smith',
          date_of_birth: Time.current.to_date,
          confirm: true
        }
      end

      it do
        expect(cmd).to be_success

        expected_subscription = Subscription.find_by!(email: email)
        expect(expected_subscription.first_name).to eq(params[:first_name])
        expect(expected_subscription.last_name).to eq(params[:last_name])
        expect(expected_subscription.date_of_birth).to eq(params[:date_of_birth])
      end

      it { expect { cmd }.to change { Subscription.all.size }.by(1) }
      it { expect { cmd }.to have_enqueued_job(SubscriptionProcessJob) }

      context 'when user already exists' do
        before do
          create(:subscription, email: 'user@example.com')
        end

        it { expect { cmd }.to raise_error(ServiceActor::Failure) }
      end
    end
  end
end
