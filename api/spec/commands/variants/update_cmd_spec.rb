# frozen_string_literal: true

RSpec.describe Variants::UpdateCmd, :aggregate_failures do
  let(:variant) { create(:variant) }
  subject { described_class.call(variant: variant, variant_params: params) }

  describe '#call' do
    context 'with valid params' do
      let(:params) do
        {
          id: variant.id,
          title_ru: Faker::Commerce.product_name,
          title_en: Faker::Commerce.product_name
        }
      end
    end

    context 'process categories after update' do
      let(:category_prev) { create(:category) }
      let(:category) { create(:category) }
      let(:variant) { create(:variant, category: category_prev) }
      let(:params) do
        {
          id: variant.id,
          category_id: category.id
        }
      end

      # it { should be_success }
      it do
        expect { subject }
          .to have_enqueued_job(CategoryProcessJob).with(category: category_prev)
          .and have_enqueued_job(VariantProcessJob).with(variant: variant)
      end
    end
  end
end
