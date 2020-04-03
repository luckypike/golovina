class Promo < ApplicationRecord

  translates :title
  globalize_accessors locales: I18n.available_locales, attributes: %i[title]
end
