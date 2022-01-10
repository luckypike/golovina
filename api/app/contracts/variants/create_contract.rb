# frozen_string_literal: true

module Variants
  class CreateContract < ApplicationContract
    params do
      optional(:product_id).maybe(:integer)

      required(:color_id).filled(:integer)
      required(:category_id).filled(:integer)
      required(:state).filled(:string)

      required(:title_ru).filled(:string)
      optional(:title_en).maybe(:string)
      optional(:desc_ru).maybe(:string)
      optional(:desc_en).maybe(:string)
      optional(:comp_ru).maybe(:string)
      optional(:comp_en).maybe(:string)

      optional(:images).maybe(:array).each do
        hash do
          required(:id).filled(:integer)
          required(:weight).filled(:integer)
          required(:active).filled(:bool)
        end
      end
    end
  end
end
