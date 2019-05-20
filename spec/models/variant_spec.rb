require 'rails_helper'

describe Variant do
  describe '#state_change' do
    context 'soon checkbox checked' do
      let(:variant) { FactoryBot.create(:variant, :with_availability, soon: true) }

      it 'change state to soon' do
        availability = variant.reload.availabilities.first
        availability.quantity -= 1
        availability.save
        variant.save
        expect(variant.availabilities.first.quantity).to eq 0 and expect(variant.state).to eq('soon')
      end
    end

    context 'soon checkbox is not checked' do
      let(:variant) { FactoryBot.create(:variant, :with_availability) }

      it 'change state to archived' do
        availability = variant.reload.availabilities.first
        availability.quantity -= 1
        availability.save
        variant.save
        expect(variant.availabilities.first.quantity).to eq 0 and expect(variant.state).to eq('archived')
      end
    end

    context 'soon checkbox without availability' do
      let(:variant) { FactoryBot.create(:variant) }

      it 'change state to archived' do
        variant.save
        expect(variant.state).to eq('archived')
      end
    end
  end
end
