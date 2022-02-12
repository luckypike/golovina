# frozen_string_literal: true

module Variants
  class CreateContract < CreateOrUpdateContract
    params do
      optional(:product_id).maybe(:integer)

      required(:color_id).filled(:integer)
      required(:category_id).filled(:integer)
      required(:state).filled(:string)
      optional(:theme_ids).array(:integer)

      required(:title_ru).filled(:string)
      optional(:title_en).maybe(:string)
      optional(:desc_ru).maybe(:string)
      optional(:desc_en).maybe(:string)
      optional(:comp_ru).maybe(:string)
      optional(:comp_en).maybe(:string)

      optional(:price).maybe(:integer)
      optional(:price_last).maybe(:integer)
      optional(:code).maybe(:string)
      optional(:published_at).maybe(:date)

      optional(:images).value(:array).each do
        hash do
          required(:id).filled(:integer)
          required(:weight).filled(:integer)
          required(:active).filled(:bool)
        end
      end
    end
  end
end
