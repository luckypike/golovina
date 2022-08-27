# frozen_string_literal: true

module Colors
  class CreateCmd < ApplicationCmd
    input :color_params
    output :color

    def call
      color = Api::Color.new
      params = validate_contract!(CreateContract, color_params)
      self.color = create_color(color, params)
    end

    private

    def create_color(color, params)
      color.transaction do
        color.assign_attributes(params)
        validate_entity!(color)
        color.save!
      end

      color
    end
  end
end
