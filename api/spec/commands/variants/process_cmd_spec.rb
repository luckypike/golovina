# frozen_string_literal: true

RSpec.describe Variants::ProcessCmd, :aggregate_failures do
  subject(:cmd) { described_class.call(variant: variant) }

  let(:variant) { create(:variant) }

  describe "#call" do
    before do
      create_list(:image, 3, processed: true, imagable: variant)
      create_list(:image, 3, processed: false, imagable: variant)
    end

    it do
      cmd

      expect(variant.reload.images_count).to eq 3
    end

    it do
      expect { cmd }.to have_enqueued_job(CategoryProcessJob).with(category: variant.category)
    end
  end
end
