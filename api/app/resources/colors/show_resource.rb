# frozen_string_literal: true

module Colors
  class ShowResource
    include Alba::Resource

    root_key :color

    attributes :id, :title_ru, :title_en, :parent_color_id, :color, :color_image
  end
end
