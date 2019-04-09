class Collection < ApplicationRecord
  extend FriendlyId

  validates_presence_of :slug, :title
  validates_uniqueness_of :slug

  friendly_id :title, use: :slugged
  # friendly_id :name, use: :slugged

  has_many :images, as: :imagable, dependent: :destroy
  accepts_nested_attributes_for :images
end
