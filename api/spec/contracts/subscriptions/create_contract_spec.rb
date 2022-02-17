# frozen_string_literal: true

RSpec.describe Subscriptions::CreateContract, :aggregate_failures do
  subject { described_class.new.call(**params) }

  describe '#call' do
    context 'with required params' do
      let(:params) do
        {
          email: "user@example.com",
          first_name: "Summer",
          last_name: "Smith",
          date_of_birth: "2000-01-01"
        }
      end

      it { should be_success }
    end

    context 'without required params' do
      let(:params) { { foo: :bar } }

      it do
        expect(subject).to be_failure
        expect(subject.errors.to_h).to include(:email, :first_name, :last_name, :date_of_birth)
      end
    end

    context 'with invalid email' do
      let(:params) do
        {
          email: "user@example",
          first_name: "Summer",
          last_name: "Smith",
          date_of_birth: "2000-01-01"
        }
      end

      it do
        expect(subject).to be_failure
        expect(subject.errors.to_h).to include(:email)
      end
    end

    context 'with invalid date' do
      let(:params) do
        {
          email: "user@example.com",
          first_name: "Summer",
          last_name: "Smith",
          date_of_birth: "2000-0101"
        }
      end

      it do
        expect(subject).to be_failure
        expect(subject.errors.to_h).to include(:date_of_birth)
      end
    end
  end
end
