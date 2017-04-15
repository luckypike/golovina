class Theme < ApplicationRecord
  extend FriendlyId

  validates_presence_of :slug
  validates_uniqueness_of :slug

  friendly_id :title, use: :slugged

  has_many :themables

  has_many :products, through: :themables, source: :themable, source_type: 'Product'
  has_many :kits, through: :themables, source: :themable, source_type: 'Kit'
end
