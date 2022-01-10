# frozen_string_literal: true

RSpec.describe ImageProcessJob, :aggregate_failures do
  describe '#perform' do
    subject { described_class.perform_now(image: image) }
    let(:image) { build(:image) }

    before do
      allow(Images::ProcessCmd).to receive(:call).and_return(true)
    end

    it do
      subject

      expect(Images::ProcessCmd).to have_received(:call).with(image: image)
    end
  end
end
