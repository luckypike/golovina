# frozen_string_literal: true

RSpec.describe ImageProcessJob, :aggregate_failures do
  describe '#perform' do
    subject(:cmd) { described_class.perform_now(image: image) }

    let(:image) { build(:image) }

    before do
      allow(Images::ProcessCmd).to receive(:call).and_return(true)
    end

    it do
      cmd

      expect(Images::ProcessCmd).to have_received(:call).with(image: image)
    end
  end
end
