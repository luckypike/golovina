# frozen_string_literal: true

RSpec.describe Subscriptions::CreateContract, :aggregate_failures do
  subject(:cmd) { described_class.new.call(**params) }

  describe '#call' do
    context 'with required params' do
      let(:params) do
        {
          email: 'user@example.com',
          first_name: 'Summer',
          last_name: 'Smith',
          date_of_birth: '2000-01-01',
          confirm: true
        }
      end

      it { is_expected.to be_success }
    end

    context 'without required params' do
      let(:params) { { foo: :bar } }

      it do
        expect(cmd).to be_failure
        expect(cmd.errors.to_h).to include(:email, :first_name, :last_name, :date_of_birth, :confirm)
      end
    end

    context 'with invalid email' do
      let(:params) do
        {
          email: 'user@example',
          first_name: 'Summer',
          last_name: 'Smith',
          date_of_birth: '2000-01-01',
          confirm: true
        }
      end

      it do
        expect(cmd).to be_failure
        expect(cmd.errors.to_h).to include(:email)
      end
    end

    context 'with invalid date' do
      let(:params) do
        {
          email: 'user@example.com',
          first_name: 'Summer',
          last_name: 'Smith',
          date_of_birth: '2000-0101',
          confirm: true
        }
      end

      it do
        expect(cmd).to be_failure
        expect(cmd.errors.to_h).to include(:date_of_birth)
      end
    end

    context 'with invalid confirm' do
      let(:params) do
        {
          email: 'user@example.com',
          first_name: 'Summer',
          last_name: 'Smith',
          date_of_birth: '2000-01-01',
          confirm: false
        }
      end

      it do
        expect(cmd).to be_failure
        expect(cmd.errors.to_h).to include(:confirm)
      end
    end
  end
end
