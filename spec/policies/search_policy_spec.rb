require 'rails_helper'

describe SearchPolicy, type: :policy do
  let(:user) { User.new }

  subject { described_class }

  permissions :index? do
    it 'grants access for all' do
      expect(subject).to permit(:search)
    end
  end
end
