# frozen_string_literal: true

module Variants
  class UpdateContract < ApplicationContract
    params do
      required(:id).filled(:integer)
      optional(:product_id).maybe(:integer)

      optional(:color_id).maybe(:integer)
      optional(:category_id).maybe(:integer)
      optional(:state).maybe(:string)

      optional(:title_ru).maybe(:string)
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
