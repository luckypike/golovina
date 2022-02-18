# frozen_string_literal: true

module Api
  class Color < ApplicationRecord
    translates :title
    globalize_accessors locales: I18n.available_locales, attributes: %i[title]
  end
end
