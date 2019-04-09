require 'rails_helper'

describe Order do
  describe '#pay' do
    let(:order) { FactoryBot.create(:order) }
    let(:user) { FactoryBot.create(:user) }

    context 'in default store' do
      let(:variant) { FactoryBot.create(:variant, :with_availabilities, quantities: [3, 3]) }
      let(:order_item) { FactoryBot.create(:order_item, order: order, variant: variant, size: variant.availabilities.first.size, quantity: 2) }

      it 'decrease quantity in store' do
        variant.decrease(order_item.quantity)
        expect(variant.availabilities.first.quantity).to eq 1 and expect(variant.availabilities.last.quantity).to eq 3
      end
    end

    context 'in other store' do
      let(:variant) { FactoryBot.create(:variant, :with_availabilities, quantities: [0, 3]) }
      let(:order_item) { FactoryBot.create(:order_item, order: order, variant: variant, size: variant.availabilities.first.size, quantity: 2) }

      it 'decrease quantity in store' do
        variant.decrease(order_item.quantity)
        expect(variant.availabilities.first.quantity).to eq 0 and expect(variant.availabilities.last.quantity).to eq 1
      end
    end

    context 'in few stores' do
      let(:variant) { FactoryBot.create(:variant, :with_availabilities, quantities: [2, 2]) }
      let(:order_item) { FactoryBot.create(:order_item, order: order, variant: variant, size: variant.availabilities.first.size, quantity: 3) }

      it 'decrease quantity in store' do
        variant.decrease(order_item.quantity)
        expect(variant.availabilities.first.quantity).to eq 0 and expect(variant.availabilities.last.quantity).to eq 1
      end
    end

    context 'only in default store' do
      let(:variant) { FactoryBot.create(:variant, :with_availability, quantity: 5) }
      let(:order_item) { FactoryBot.create(:order_item, order: order, variant: variant, size: variant.availabilities.first.size, quantity: 4) }

      it 'decrease quantity in store' do
        variant.decrease(order_item.quantity)
        expect(variant.availabilities.first.quantity).to eq 1
      end
    end
  end
end
