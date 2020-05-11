require 'rails_helper'

describe Accounts::UserPolicy do
  subject { described_class }

  let(:anonymous_user) { nil }
  let(:guest_user) { create(:guest_user) }
  let(:common_user) { create(:common_user) }

  permissions :edit?, :update?, :password? do
    it 'grants access for common user' do
      expect(subject).to permit(common_user, common_user)
    end
  end

  permissions :edit?, :update?, :password? do
    it 'denies access for guest user' do
      expect(subject).not_to permit(guest_user, guest_user)
    end
  end

  permissions :edit?, :update?, :password? do
    it 'denies access for anonymous user' do
      expect(subject).not_to permit(anonymous_user, anonymous_user)
    end
  end
end
