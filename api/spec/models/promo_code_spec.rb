# frozen_string_literal: true

RSpec.describe PromoCode, :aggregate_failures do
  describe "#apply" do
    subject { promo_code.apply(amount) }

    let(:amount) { 10_000 }

    context "when amount 11_000" do
      let(:promo_code) { create(:promo_code, value: 11_000) }

      it { is_expected.to eq(0) }
    end

    context "when amount -1_000" do
      let(:promo_code) { create(:promo_code, value: -1_000) }

      it { is_expected.to eq(10_000) }
    end

    context "when amount 4_000" do
      let(:promo_code) { create(:promo_code, value: 4_000) }

      it { is_expected.to eq(6_000) }
    end

    context "when percentage 1.1" do
      let(:promo_code) { create(:promo_code, :percentage, value: 1.1) }

      it { is_expected.to eq(0) }
    end

    context "when percentage 0.4" do
      let(:promo_code) { create(:promo_code, :percentage, value: 0.4) }

      it { is_expected.to eq(6_000) }
    end

    context "when percentage -1.1" do
      let(:promo_code) { create(:promo_code, :percentage, value: -1.1) }

      it { is_expected.to eq(10_000) }
    end
  end
end
