class Collection < ApplicationRecord
  extend FriendlyId

  validates :slug, :title, presence: true
  validates :slug, uniqueness: true

  friendly_id :title, use: :slugged

  has_many :images, as: :imagable, dependent: :destroy
  accepts_nested_attributes_for :images

  translates :text, :title
  globalize_accessors locales: I18n.available_locales, attributes: %i[text title]

  class << self
    def for_header
      order(weight: :asc, id: :desc)
    end
  end
end
