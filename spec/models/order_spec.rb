require 'rails_helper'

describe Order do
  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:user_address).optional }
    it { should belong_to(:delivery_city).optional }
    it { should have_many(:order_items) }
    it { should accept_nested_attributes_for(:user).update_only(true) }
  end

  describe 'validation' do
    context 'with guest user' do
      subject { build(:order, :guest_user) }

      it { should_not validate_presence_of(:delivery) }
      it { is_expected.to be_valid }
    end

    context 'ready to pay' do
      before do
        allow(subject).to receive(:to_pay).and_return(true)
      end

      it { should validate_presence_of(:delivery) }
      it { should_not validate_presence_of(:delivery_option) }

      context 'for pickup' do
        it { should_not validate_presence_of(:city) }
        it { should_not validate_presence_of(:country) }
        it { should_not validate_presence_of(:street) }
        it { should_not validate_presence_of(:house) }
        it { should_not validate_presence_of(:appartment) }
      end

      context 'for russia' do
        before do
          allow(subject).to receive(:russia?).and_return(true)
        end

        it { should validate_presence_of(:delivery_option) }

        context 'to door' do
          before do
            allow(subject).to receive(:door?).and_return(true)
          end

          it { should validate_presence_of(:street) }
          it { should validate_presence_of(:house) }
          it { should validate_presence_of(:appartment) }
        end

        context 'to storage' do
          before do
            allow(subject).to receive(:door?).and_return(false)
          end

          it { should_not validate_presence_of(:street) }
          it { should_not validate_presence_of(:house) }
          it { should_not validate_presence_of(:appartment) }
        end
      end

      context 'for international' do
        before do
          allow(subject).to receive(:international?).and_return(true)
        end

        it { should_not validate_presence_of(:delivery_option) }
        it { should validate_presence_of(:country) }
        it { should validate_presence_of(:city) }
        it { should validate_presence_of(:street) }
        it { should validate_presence_of(:house) }
        it { should validate_presence_of(:appartment) }
      end

      # it { is_expected.not_to be_valid }

      context 'with guest user' do
        before do
          allow(subject).to receive(:delivery).and_return(:pickup)
        end

        context 'with guest user' do
          subject { build(:order, :guest_user) }

          it { is_expected.to be_valid }
        end
      end
    end
  end

  # describe '#pay' do
  #
  #   let(:order) { create(:order) }
  # end

  # describe '#pay' do
  #   let(:order) { FactoryBot.create(:order) }
  #   let(:user) { FactoryBot.create(:user) }
  #
  #   context 'in default store' do
  #     let(:variant) { FactoryBot.create(:variant, :with_availabilities, quantities: [3, 3]) }
  #     let(:order_item) { FactoryBot.create(:order_item, order: order, variant: variant, size: variant.reload.availabilities.first.size, quantity: 2) }
  #
  #     it 'decrease quantity in store' do
  #       variant.decrease(order_item)
  #       expect(variant.availabilities.first.quantity).to eq 1 and expect(variant.availabilities.last.quantity).to eq 3
  #     end
  #   end
  #
  #   context 'in other store' do
  #     let(:variant) { FactoryBot.create(:variant, :with_availabilities, quantities: [0, 3]) }
  #     let(:order_item) { FactoryBot.create(:order_item, order: order, variant: variant, size: variant.reload.availabilities.first.size, quantity: 2) }
  #
  #     it 'decrease quantity in store' do
  #       variant.decrease(order_item)
  #       expect(variant.availabilities.first.quantity).to eq 0 and expect(variant.availabilities.last.quantity).to eq 1
  #     end
  #   end
  #
  #   context 'in few stores' do
  #     let(:variant) { FactoryBot.create(:variant, :with_availabilities, quantities: [2, 2]) }
  #     let(:order_item) { FactoryBot.create(:order_item, order: order, variant: variant, size: variant.reload.availabilities.first.size, quantity: 3) }
  #
  #     it 'decrease quantity in store' do
  #       variant.decrease(order_item)
  #       expect(variant.availabilities.first.quantity).to eq 0 and expect(variant.availabilities.last.quantity).to eq 1
  #     end
  #   end
  #
  #   context 'only in default store' do
  #     let(:variant) { FactoryBot.create(:variant, :with_availability, quantity: 5) }
  #     let(:order_item) { FactoryBot.create(:order_item, order: order, variant: variant, size: variant.reload.availabilities.first.size, quantity: 4) }
  #
  #     it 'decrease quantity in store' do
  #       variant.decrease(order_item)
  #       expect(variant.availabilities.first.quantity).to eq 1
  #     end
  #   end
  # end
end
