# frozen_string_literal: true

module Api
  class Variant < ApplicationRecord
    include Variants::ElasticsearchConcern

    enum state: { unpub: 0, active: 1, archived: 2 }

    belongs_to :color
    belongs_to :product
    belongs_to :category, optional: true
    has_many :images, as: :imagable, dependent: :destroy
    has_many :themables, dependent: :destroy
    has_many :themes, through: :themables

    translates :desc, :comp, :title
    globalize_accessors locales: I18n.available_locales, attributes: %i[desc comp title]

    validates :title_ru, :state, presence: true

    def price_final
      [price, price_last].compact.min
    end
  end
end
