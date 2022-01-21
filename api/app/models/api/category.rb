# frozen_string_literal: true

module Api
  class Category < ApplicationRecord
    enum state: { inactive: 0, active: 1 }

    has_many :variants, dependent: :restrict_with_exception
    has_many :kits, dependent: :restrict_with_exception

    translates :title, :desc
    globalize_accessors locales: I18n.available_locales, attributes: %i[title desc]
  end
end
