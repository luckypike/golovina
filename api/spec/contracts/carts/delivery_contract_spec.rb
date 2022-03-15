# frozen_string_literal: true

RSpec.describe Carts::DeliveryContract, :aggregate_failures do
  subject(:contract) { described_class.new.call(delivery_params) }

  describe "#call" do
    context "without params" do
      let(:delivery_params) { {} }

      it { is_expected.to be_failure }
      it { expect(contract.errors.to_h.keys).to include(:delivery) }
    end

    context "with delivery_russia and without option and city" do
      let(:delivery_params) { { delivery: "russia", delivery_option: "", delivery_city_id: "" } }

      it { expect(contract.errors.to_h.keys).not_to include(:delivery) }
      it { expect(contract.errors.to_h.keys).to include(:delivery_city_id, :delivery_option) }
    end

    context "with delivery_russia and with option and city" do
      let(:delivery_params) { { delivery: "russia", delivery_option: "door", delivery_city_id: 99 } }

      it { expect(contract.errors.to_h.keys).not_to include(:delivery_city_id, :delivery_option) }
    end

    context "with delivery_russia and without address" do
      let(:delivery_params) { { delivery: "russia", zip: "", street: "", house: "", appartment: "" } }

      it { expect(contract.errors.to_h.keys).to include(:zip, :street, :house, :appartment) }
    end

    context "with delivery_russia and with address" do
      let(:delivery_params) { { delivery: "russia", zip: "600000", street: "High st.", house: "90", appartment: "-" } }

      it { expect(contract.errors.to_h.keys).not_to include(:zip, :street, :house, :appartment) }
    end

    context "with delivery_international and without option and city" do
      let(:delivery_params) { { delivery: "international", delivery_option: "", delivery_city_id: "" } }

      it { expect(contract.errors.to_h.keys).not_to include(:delivery, :delivery_city_id, :delivery_option) }
    end

    context "with delivery_international and without address" do
      let(:delivery_params) do
        { delivery: "international", country: "", city: "", zip: "", street: "", house: "", appartment: "" }
      end

      it { expect(contract.errors.to_h.keys).to include(:zip, :country, :city, :street, :house, :appartment) }
    end

    context "with delivery_international and with address" do
      let(:delivery_params) do
        {
          delivery: "international", country: "Germany", city: "Berlin",
          zip: "600000", street: "Munchener st.", house: "12", appartment: "5"
        }
      end

      it { expect(contract.errors.to_h.keys).not_to include(:zip, :country, :city, :street, :house, :appartment) }
    end
  end
end
