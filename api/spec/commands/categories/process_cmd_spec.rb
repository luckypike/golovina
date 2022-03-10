# frozen_string_literal: true

RSpec.describe Categories::ProcessCmd, :aggregate_failures do
  subject(:cmd) { described_class.call(category: category) }

  let(:category) { create(:category) }

  describe '#call' do
    before do
      create_list(:variant, 3, category: category)
      create_list(:kit, 2, category: category)
    end

    it do
      cmd
      expect(category.reload.variants_and_kits_count).to eq 5
    end
  end
end
