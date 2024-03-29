# frozen_string_literal: true

describe User do
  describe "associations" do
    it { is_expected.to have_many(:orders) }
    it { is_expected.to have_many(:user_addresses) }
  end

  describe "validation" do
    it { is_expected.to validate_presence_of(:email) }

    context "when guest?" do
      it { is_expected.not_to validate_presence_of(:name) }
      it { is_expected.not_to validate_presence_of(:sname) }
      it { is_expected.not_to validate_presence_of(:phone) }
    end

    context "when common?" do
      before do
        allow(subject).to receive(:common?).and_return(true)
      end

      it { is_expected.to validate_presence_of(:name) }
      it { is_expected.to validate_presence_of(:sname) }
      it { is_expected.to validate_presence_of(:phone) }

      context "when skip validate" do
        before do
          allow(subject).to receive(:skip_validation).and_return(true)
        end

        it { is_expected.not_to validate_presence_of(:name) }
        it { is_expected.not_to validate_presence_of(:sname) }
        it { is_expected.not_to validate_presence_of(:phone) }
      end
    end
  end

  describe "#password_required?" do
    context "when guest?" do
      it { is_expected.not_to validate_presence_of(:password) }
    end

    context "when common?" do
      before do
        allow(subject).to receive(:guest?).and_return(false)
      end

      it { is_expected.to validate_presence_of(:password) }
    end
  end
end
