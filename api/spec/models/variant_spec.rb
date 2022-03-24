# frozen_string_literal: true

describe Variant do
  describe "associations" do
    it { is_expected.to belong_to(:color) }
    it { is_expected.to have_many(:availabilities) }
  end
end
