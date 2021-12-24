require 'rails_helper'

describe SearchPolicy do
  subject { described_class }

  let(:user) { nil }

  permissions :index? do
    it 'grants access for all' do
      expect(subject).to permit(user, :search)
    end
  end
end
