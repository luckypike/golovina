require 'rails_helper'

describe PagePolicy do
  subject { described_class }

  let(:user) { nil }

  permissions :index?, :contacts?, :robots? do
    it 'grants access for all' do
      expect(subject).to permit(user, :page)
    end
  end
end
