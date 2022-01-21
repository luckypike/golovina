# frozen_string_literal: true

module Images
  class CreateCmd < ApplicationCmd
    input :image_params
    output :image

    def call
      params = validate_contract!(CreateContract, image_params)

      image = build_image(params)
      image.save!

      self.image = image
    end

    private

    def build_image(params)
      Api::Image.new(params)
    end
  end
end
