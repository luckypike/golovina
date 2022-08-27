# frozen_string_literal: true

module Api
  class Color < ApplicationRecord
    belongs_to :parent_color, class_name: "Api::Color", optional: true
    has_many :colors, -> { order(title_ru: :asc) }, class_name: "Api::Color", foreign_key: :parent_color_id,
      dependent: :destroy, inverse_of: :parent_color

    validates :title_ru, :title_en, :color, presence: true

    def title
      (send("title_#{I18n.locale}") || "").strip
    end
  end
end
