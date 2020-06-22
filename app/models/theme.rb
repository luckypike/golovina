class Theme < ApplicationRecord
  extend FriendlyId

  enum state: { inactive: 0, active: 1 }

  has_many :themables, dependent: :destroy
  has_many :variants, through: :themables

  # validates :state, :title_ru, presence: true
  validates :slug, uniqueness: true, presence: true, format: { with: /\A[a-z0-9-]+\z/, message: :only_slug }

  friendly_id :slug
  translates :title, :desc
  globalize_accessors locales: I18n.available_locales, attributes: %i[title desc]

  class << self
    def nav
      with_translations(I18n.available_locales).active.order(weight: :asc)
    end
  end
end
