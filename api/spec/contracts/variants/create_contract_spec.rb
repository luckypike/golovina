# frozen_string_literal: true

RSpec.describe Variants::CreateContract, :aggregate_failures do
  subject { described_class.new.call(**params) }

  describe '#call' do
    context 'with required params' do
      let(:params) { { category_id: 1, color_id: 1, state: 'active', title_ru: 'Title ru' } }

      it { should be_success }
    end

    context 'without required params' do
      let(:params) { { foo: :bar } }

      it do
        expect(subject).to be_failure
        expect(subject.errors.to_h).to include(:category_id, :color_id, :state, :title_ru)
      end
    end

    context 'with nil optional params' do
      let(:params) do
        {
          category_id: 1, color_id: 1, state: 'active', title_ru: 'Title ru',
          title_en: nil, code: nil, published_at: nil
        }
      end

      it { should be_success }
    end

    context 'with wrong params' do
      let(:params) { { category_id: nil, title_ru: '', color_id: 'qqq' } }

      it do
        expect(subject).to be_failure
        expect(subject.errors.to_h).to include(:category_id, :title_ru, :color_id)
      end
    end

    context 'with all params' do
      let(:params) do
        {
          product_id: 1, category_id: 1, color_id: 1, state: 'active',
          title_ru: 'Title ru', title_en: 'Title en', desc_ru: 'Desc ru', desc_en: 'Desc en',
          comp_ru: 'Comp ru', comp_en: 'Comp en', price: 123, price_last: 122, code: 'Code',
          published_at: Time.current.to_date, images: [
            { id: 1, weight: 1, active: true },
            { id: 2, weight: 2, active: false }
          ]
        }
      end

      it do
        expect(subject).to be_success
        expect(subject.to_h).to include(
          :product_id, :category_id, :color_id, :state, :title_ru, :title_en, :desc_ru, :desc_en,
          :comp_ru, :comp_en, :price, :price_last, :code, :published_at, :images
        )
        expect(subject.to_h[:images].first).to include(:id, :weight, :active)
      end
    end
  end
end
