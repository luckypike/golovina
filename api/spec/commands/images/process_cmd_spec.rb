# frozen_string_literal: true

RSpec.describe Images::ProcessCmd, :aggregate_failures do
  subject(:cmd) { described_class.call(image: image) }

  let(:variant) { create(:variant) }
  let(:image) { create(:image, imagable: variant) }

  describe '#call' do
    it do
      expect { cmd }.to have_enqueued_job(VariantProcessJob).with(variant: variant)
    end
  end
end
