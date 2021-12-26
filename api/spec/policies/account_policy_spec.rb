require 'rails_helper'

describe AccountPolicy do
  subject { described_class }

  let(:anonymous_user) { nil }
  let(:guest_user) { create(:guest_user) }
  let(:common_user) { create(:common_user) }

  permissions :show? do
    it 'grants access for common user' do
      expect(subject).to permit(common_user, :account)
    end
  end

  permissions :show? do
    it 'denies access for guest user' do
      expect(subject).not_to permit(guest_user, :account)
    end
  end

  permissions :show? do
    it 'denies access for anonymous user' do
      expect(subject).not_to permit(anonymous_user, :account)
    end
  end
end
