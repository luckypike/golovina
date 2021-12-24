require 'rails_helper'

describe DashboardPolicy do
  subject { described_class }

  let(:anonymous_user) { nil }
  let(:guest_user) { create(:guest_user) }
  let(:common_user) { create(:common_user) }
  let(:editor_user) { create(:common_user, :editor) }

  permissions :index?, :cart?, :archived?, :refunds?, :wishlists? do
    it 'denies access for common user' do
      expect(subject).not_to permit(common_user, :dashboard)
    end
  end

  permissions :index?, :cart?, :archived?, :refunds?, :wishlists? do
    it 'denies access for guest user' do
      expect(subject).not_to permit(guest_user, :dashboard)
    end
  end

  permissions :index?, :cart?, :archived?, :refunds?, :wishlists? do
    it 'denies access for anonymous user' do
      expect(subject).not_to permit(anonymous_user, :dashboard)
    end
  end

  permissions :index?, :cart?, :archived?, :refunds?, :wishlists? do
    it 'allow access for editor' do
      expect(subject).to permit(editor_user, :dashboard)
    end
  end
end
