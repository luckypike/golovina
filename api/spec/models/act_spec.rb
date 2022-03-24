# frozen_string_literal: true

describe Act do
  describe "associations" do
    it { is_expected.to belong_to(:store) }
    it { is_expected.to belong_to(:availability) }
  end

  describe "validation" do
    it { is_expected.to validate_presence_of(:quantity) }
  end
end
