require 'rails_helper'

describe PagesPolicy do
  subject { described_class }

  let(:user) { nil }

  permissions :index?, :contacts?, :robots? do
    it 'grants access for all' do
      expect(subject).to permit(user, :pages)
    end
  end
end
