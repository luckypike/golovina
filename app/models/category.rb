# require 'babosa'

class Category < ApplicationRecord
  extend FriendlyId

  enum state: { inactive: 0, active: 1 }

  has_many :products, dependent: :nullify
  has_many :variants, through: :products

  validates :state, :title_ru, :title_en, presence: true
  validates :slug, uniqueness: true, presence: true, format: { with: /\A[a-z-]+\z/, message: :only_slug }

  translates :title
  globalize_accessors locales: I18n.available_locales, attributes: [:title]
  friendly_id :slug

  # def normalize_friendly_id(input)
  #   input.to_s.to_slug.normalize(transliterations: :russian).to_s
  # end

  # def check
  #   update_attribute(:variants_counter, variants.active.size)
  # end
end
