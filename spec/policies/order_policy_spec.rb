require 'rails_helper'

describe OrderPolicy do
  subject { described_class }

  let(:anonymous_user) { nil }
  let(:guest_user) { create(:guest_user) }

  permissions :cart?, :paid? do
    it 'grants access for all' do
      expect(subject).to permit(anonymous_user, Order)
    end
  end

  permissions :checkout?, :pay? do
    it 'grants access for owner' do
      order = create(:order, user: guest_user)

      expect(subject).to permit(guest_user, order)
    end

    it 'denies access for all' do
      order = create(:order, :guest_user)

      expect(subject).not_to permit(guest_user, order)
    end
  end

  permissions :index? do
    it 'denies access for all' do
      expect(subject).not_to permit(anonymous_user, Order)
      expect(subject).not_to permit(guest_user, Order)
    end
  end
end
