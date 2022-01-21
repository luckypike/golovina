# frozen_string_literal: true

RSpec.describe Variants::ProcessCmd, :aggregate_failures do
  let(:variant) { create(:variant) }

  subject { described_class.call(variant: variant) }

  # before do
  #   stub_request(:get, 'http://es:9200/').to_return(status: 200, body: { version: { number: "7.16.2" } }.to_json, headers: { content_type: 'application/json', 'x-elastic-product': 'Elasticsearch' })
  # end

  describe '#call' do
    before do
      create_list(:image, 3, processed: true, imagable: variant)
      create_list(:image, 3, processed: false, imagable: variant)
    end

    it do
      subject

      expect(variant.reload.images_count).to eq 3
    end

    it do
      expect { subject }.to have_enqueued_job(CategoryProcessJob).with(category: variant.category)
    end
  end
end
