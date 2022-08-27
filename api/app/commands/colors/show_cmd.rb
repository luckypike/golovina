# frozen_string_literal: true

module Colors
  class ShowCmd < ApplicationCmd
    input :color_id
    output :color

    def call
      self.color = Api::Color.find(color_id)
      # self.color = ColorModel.first!(id: color_id)
    end
  end
end
