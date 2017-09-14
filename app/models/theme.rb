class Theme < ApplicationRecord
  enum state: { inactive: 0, active: 1 }

  extend FriendlyId

  validates_presence_of :slug
  validates_uniqueness_of :slug

  friendly_id :title, use: :slugged

  # has_many :products, through: :themables, source: :themable, source_type: 'Product'
  has_many :kits
end
