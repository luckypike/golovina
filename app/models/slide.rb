class Slide < ApplicationRecord
  translates :name
  globalize_accessors locales: I18n.available_locales, attributes: [:name]
  mount_uploader :image, SlideUploader

  accepts_nested_attributes_for :translations
end
