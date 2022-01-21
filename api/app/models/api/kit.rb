# frozen_string_literal: true

module Api
  class Kit < ApplicationRecord
    include Variants::ElasticsearchConcern

    enum state: { unpub: 0, active: 1, archived: 2 }

    belongs_to :category, optional: true

    translates :title
    globalize_accessors locales: I18n.available_locales, attributes: %i[title]

    validates :title_ru, :state, presence: true
  end
end
