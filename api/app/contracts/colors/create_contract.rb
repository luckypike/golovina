# frozen_string_literal: true

module Colors
  class CreateContract < ApplicationContract
    params do
      required(:title_ru).filled(:string)
      required(:title_en).filled(:string)
      required(:color).filled(:string)
      optional(:color_image).maybe(:string)
      optional(:parent_color_id).maybe(:integer)
    end

    rule(:parent_color_id) do
      key.failure(:parent?) if value && Api::Color.find_by(id: value)&.parent_color_id.present?
    end
  end
end
