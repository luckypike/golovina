# frozen_string_literal: true

RSpec.describe Colors::UpdateContract, :aggregate_failures do
  subject(:contract) { described_class.new(color: color).call(color_params) }

  context "without params" do
    let(:color_params) { {} }
    let(:color) { create(:api_color) }

    it { is_expected.to be_failure }
    it { expect(contract.errors.to_h.keys).to include(:title_en, :title_ru, :color) }
  end

  context "with parent and has colors" do
    let(:color_params) do
      {
        title_en: Faker::Color.color_name,
        title_ru: Faker::Color.color_name,
        color: Faker::Color.hex_color,
        parent_color_id: parent_color.id
      }
    end
    let(:color) { create(:api_color, :with_colors) }
    let(:parent_color) { create(:api_color) }

    it { expect(contract.errors.to_h.keys).to include(:parent_color_id) }
  end

  context "with 3 lvl" do
    let(:color_params) do
      {
        title_en: Faker::Color.color_name,
        title_ru: Faker::Color.color_name,
        color: Faker::Color.hex_color,
        parent_color_id: parent_color.id
      }
    end
    let(:color) { create(:api_color) }
    let(:parent_color) { create(:api_color, :with_parent_color) }

    it { expect(contract.errors.to_h.keys).to include(:parent_color_id) }
  end

  context "when self parent" do
    let(:color_params) do
      {
        title_en: Faker::Color.color_name,
        title_ru: Faker::Color.color_name,
        color: Faker::Color.hex_color,
        parent_color_id: color.id
      }
    end
    let(:color) { create(:api_color) }

    it { expect(contract.errors.to_h.keys).to include(:parent_color_id) }
  end
end
