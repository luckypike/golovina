# require 'babosa'

class Category < ApplicationRecord
  extend FriendlyId

  enum state: { inactive: 0, active: 1 }

  has_many :products, dependent: :nullify
  has_many :variants, through: :products

  validates :state, :title_ru, presence: true
  validates :slug, uniqueness: true, presence: true, format: { with: /\A[a-z0-9-]+\z/, message: :only_slug }

  translates :title
  globalize_accessors locales: I18n.available_locales, attributes: [:title]
  friendly_id :slug

  def check_variants_counter
    update_attribute(:variants_counter, variants.active.size)
  end

  class << self
    def nav
      with_translations(I18n.available_locales).active
        .where.not(variants_counter: 0).order(weight: :asc)
    end
  end
end
