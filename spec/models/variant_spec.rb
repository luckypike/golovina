require 'rails_helper'

describe Variant do
  describe 'associations' do
    it { should belong_to(:color) }
    it { should have_many(:availabilities) }
  end

  # describe '#state_change' do
  #   context 'soon checkbox checked' do
  #     let(:variant) { FactoryBot.create(:variant, :with_availability, soon: true) }
  #
  #     it 'change state to soon' do
  #       availability = variant.reload.availabilities.first
  #       availability.quantity -= 1
  #       availability.save
  #       variant.save
  #       expect(variant.availabilities.first.quantity).to eq 0
  #     end
  #   end
  #
  #   context 'soon checkbox is not checked' do
  #     let(:variant) { FactoryBot.create(:variant, :with_availability) }
  #
  #     it 'change state to archived' do
  #       availability = variant.reload.availabilities.first
  #       availability.quantity -= 1
  #       availability.save
  #       variant.save
  #       expect(variant.availabilities.first.quantity).to eq 0
  #     end
  #   end
  # end
end
