# frozen_string_literal: true

RSpec.describe Variants::CreateCmd, :aggregate_failures do
  let(:category) { create(:category) }
  let(:color) { create(:color) }
  subject { described_class.call(variant_params: params) }

  describe '#call' do
    context 'with valid params' do
      context 'without product_id' do
        let(:params) do
          {
            title_ru: Faker::Commerce.product_name, state: 'unpub',
            color_id: color.id, category_id: category.id
          }
        end

        it { should be_success }
        it { expect(subject.variant.slice(:title_ru, :color_id, :category_id, :state)).to match(params) }
        it do
          expect { subject }
            .to change { Api::Variant.all.size }.by(1)
            .and change { Api::Product.all.size }.by(1)
        end

        it do
          expect { subject }.to have_enqueued_job(VariantProcessJob)
        end
      end

      context 'with product_id' do
        let(:product_id) { 1 }
        let(:params) do
          {
            title_ru: Faker::Commerce.product_name, state: 'unpub',
            color_id: color.id, category_id: category.id, product_id: product_id
          }
        end

        before do
          create(:product, id: product_id)
        end

        it { should be_success }
        it { expect(subject.variant.slice(:title_ru, :color_id, :category_id, :product_id, :state)).to match(params) }
        it do
          expect { subject }
            .to change { Api::Variant.all.size }.by(1)
            .and change { Api::Product.all.size }.by(0)
        end
      end
    end
  end
end
