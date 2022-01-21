# frozen_string_literal: true

namespace :migrate do
  namespace :variants do
    desc 'Move category from product to variant'
    task category_and_title: :environment do
      Api::Variant.with_translations.find_each do |variant|
        product = Product.find(variant.product_id)
        variant.title_ru = variant.title_ru.presence || product.title_ru
        variant.title_en = variant.title_en.presence || product.title_en
        variant.category_id = variant.category_id.presence || product.category_id
        variant.save!
      end
    end
  end
end
