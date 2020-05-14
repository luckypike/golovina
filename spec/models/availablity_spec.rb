require 'rails_helper'

describe Availability do
  describe 'associations' do
    it { is_expected.to belong_to(:variant) }
    it { is_expected.to belong_to(:size) }
    it { is_expected.to have_many(:acts) }
  end

  describe 'validation' do
    it { is_expected.to validate_presence_of(:quantity) }
  end
end
