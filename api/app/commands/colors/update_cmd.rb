# frozen_string_literal: true

module Colors
  class UpdateCmd < ApplicationCmd
    input :color_id
    input :color_params
    output :color

    def call
      color = find_color(color_id)
      params = validate_contract!(UpdateContract, color_params, color: color)
      self.color = update_color(color, params)
    end

    private

    def find_color(color_id)
      Api::Color.find(color_id)
    end

    def update_color(color, params)
      color.transaction do
        color.lock!
        color.assign_attributes(params)
        validate_entity!(color)
        color.save!
      end

      color
    end
  end
end
