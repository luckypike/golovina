# frozen_string_literal: true

describe UserAddress do
  describe "associations" do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:delivery_city).optional }
  end

  describe "validation" do
    context "when russia?" do
      before do
        allow(subject).to receive(:delivery_city).and_return(true)
      end

      it { is_expected.to validate_presence_of(:delivery_option) }
      it { is_expected.not_to validate_presence_of(:country) }
      it { is_expected.not_to validate_presence_of(:city) }

      context "when door" do
        before do
          allow(subject).to receive(:door?).and_return(true)
        end

        it { is_expected.to validate_presence_of(:street) }
        it { is_expected.to validate_presence_of(:house) }
        it { is_expected.to validate_presence_of(:appartment) }
      end

      context "when storage" do
        before do
          allow(subject).to receive(:door?).and_return(false)
        end

        it { is_expected.not_to validate_presence_of(:street) }
        it { is_expected.not_to validate_presence_of(:house) }
        it { is_expected.not_to validate_presence_of(:appartment) }
      end
    end

    context "when international?" do
      before do
        allow(subject).to receive(:delivery_city).and_return(false)
      end

      it { is_expected.not_to validate_presence_of(:delivery_option) }
      it { is_expected.to validate_presence_of(:country) }
      it { is_expected.to validate_presence_of(:city) }
      it { is_expected.to validate_presence_of(:street) }
      it { is_expected.to validate_presence_of(:house) }
      it { is_expected.to validate_presence_of(:appartment) }
    end
  end
end
