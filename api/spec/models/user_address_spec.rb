require 'rails_helper'

describe UserAddress do
  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:delivery_city).optional }
  end

  describe 'validation' do
    context 'if russia?' do
      before do
        allow(subject).to receive(:delivery_city).and_return(true)
      end

      it { should validate_presence_of(:delivery_option) }
      it { should_not validate_presence_of(:country) }
      it { should_not validate_presence_of(:city) }

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

    context 'if international?' do
      before do
        allow(subject).to receive(:delivery_city).and_return(false)
      end

      it { should_not validate_presence_of(:delivery_option) }
      it { should validate_presence_of(:country) }
      it { should validate_presence_of(:city) }
      it { should validate_presence_of(:street) }
      it { should validate_presence_of(:house) }
      it { should validate_presence_of(:appartment) }
    end
  end
end
