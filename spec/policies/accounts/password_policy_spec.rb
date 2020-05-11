require 'rails_helper'

describe Accounts::PasswordPolicy do
  subject { described_class }

  let(:anonymous_user) { nil }
  let(:guest_user) { create(:guest_user) }
  let(:common_user) { create(:common_user) }

  permissions :show?, :update? do
    it 'grants access for common user' do
      expect(subject).to permit(common_user, :password)
    end
  end

  permissions :show?, :update? do
    it 'grants access for guest user' do
      expect(subject).to permit(guest_user, :password)
    end
  end

  permissions :show?, :update? do
    it 'grants access for anonymous user' do
      expect(subject).to permit(anonymous_user, :password)
    end
  end
end
