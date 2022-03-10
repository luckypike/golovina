# frozen_string_literal: true

RSpec.describe Api::Order, :aggregate_failures do
  describe '#price_delivery' do
    subject { order.price_delivery }

    context 'when order is international' do
      let(:order) { create(:api_order, :cart, delivery: :international) }

      it { is_expected.to eq(2_800) }
    end

    context 'when order is pickup' do
      let(:order) { create(:api_order, :cart, delivery: :pickup) }

      it { is_expected.to eq(0) }
    end

    context 'when order is russia but without city' do
      let(:order) { create(:api_order, :cart, delivery: :russia) }

      it { is_expected.to be_nil }
    end

    context 'when order is russia and delivery_option is door' do
      let(:delivery_city) { create(:delivery_city) }
      let(:order) { create(:api_order, :cart, delivery: :russia, delivery_city: delivery_city, delivery_option: :door) }

      it { is_expected.to eq(delivery_city.door) }
    end

    context 'when order is russia and delivery_option is nil' do
      let(:delivery_city) { create(:delivery_city) }
      let(:order) { create(:api_order, :cart, delivery: :russia, delivery_city: delivery_city) }

      it { is_expected.to be_nil }
    end

    context 'when order is russia and delivery_option is storage' do
      let(:delivery_city) { create(:delivery_city) }
      let(:order) do
        create(:api_order, :cart, delivery: :russia, delivery_city: delivery_city, delivery_option: :storage)
      end

      it { is_expected.to eq(delivery_city.storage) }
    end
  end
end
