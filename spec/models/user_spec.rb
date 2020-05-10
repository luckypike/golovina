require 'rails_helper'

describe User do
  describe 'associations' do
    it { is_expected.to have_many(:orders) }
    it { is_expected.to have_many(:user_addresses) }
  end

  describe 'validation' do
    it { is_expected.to validate_presence_of(:email) }

    context 'if guest?' do
      it { is_expected.not_to validate_presence_of(:name) }
      it { is_expected.not_to validate_presence_of(:sname) }
      it { is_expected.not_to validate_presence_of(:phone) }
    end

    context 'if common?' do
      before do
        allow(subject).to receive(:guest?).and_return(false)
      end

      it { is_expected.to validate_presence_of(:name) }
      it { is_expected.to validate_presence_of(:sname) }
      it { is_expected.to validate_presence_of(:phone) }
    end
  end

  describe '#password_required?' do
    context 'if guest?' do
      it { is_expected.not_to validate_presence_of(:password) }
    end

    context 'if common?' do
      before do
        allow(subject).to receive(:guest?).and_return(false)
      end

      it { is_expected.to validate_presence_of(:password) }
    end
  end
end
