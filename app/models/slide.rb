class Slide < ApplicationRecord
  translates :name
  globalize_accessors locales: I18n.available_locales, attributes: [:name]

  validates :name_ru, :link, presence: true

  mount_uploader :image, SlideUploader

  accepts_nested_attributes_for :translations

  def link_relative
    URI(link).path
  end
end
