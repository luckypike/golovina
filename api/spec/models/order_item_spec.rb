require 'rails_helper'

describe OrderItem do
  describe 'associations' do
    it { is_expected.to belong_to(:order) }
    it { is_expected.to belong_to(:variant) }
    it { is_expected.to belong_to(:size) }
  end

  describe 'validation' do
    it { is_expected.to validate_presence_of(:quantity) }
  end
end
