class Theme < ApplicationRecord
  extend FriendlyId

  enum state: { inactive: 0, active: 1 }

  # validates :state, :title_ru, presence: true
  validates :slug, uniqueness: true, presence: true, format: { with: /\A[a-z0-9-]+\z/, message: :only_slug }

  friendly_id :slug
  translates :title, :desc
end
