# frozen_string_literal: true

RSpec.describe Carts::CheckoutContract, :aggregate_failures do
  subject(:contract) { described_class.new.call(checkout_params) }

  describe '#call' do
    context 'without params' do
      let(:checkout_params) { {} }

      it { is_expected.to be_failure }
      it { expect(contract.errors.to_h.keys).to include(:name, :sname, :phone, :email) }
    end

    context 'with wrong phone' do
      let(:checkout_params) do
        {
          phone: 'wrong phone'
        }
      end

      it { expect(contract.errors.to_h.keys).to include(:phone) }
    end

    context 'with wrong email' do
      let(:checkout_params) do
        {
          email: 'wrong email'
        }
      end

      it { expect(contract.errors.to_h.keys).to include(:email) }
    end
  end
end
