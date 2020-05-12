require 'rails_helper'

describe SessionPolicy do
  subject { described_class }

  let(:anonymous_user) { nil }
  let(:guest_user) { create(:guest_user) }
  let(:common_user) { create(:common_user) }

  permissions :new?, :create? do
    it 'grants access for all' do
      expect(subject).to permit(anonymous_user, :page)
    end
  end

  permissions :new?, :create? do
    it 'grants access for guest' do
      expect(subject).to permit(guest_user, :page)
    end
  end

  permissions :new? do
    it 'grants access common user' do
      expect(subject).to permit(common_user, :page)
    end
  end

  permissions :create? do
    it 'denies access common user' do
      expect(subject).to permit(common_user, :page)
    end
  end
end
