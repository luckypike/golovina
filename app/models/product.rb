class Product < ApplicationRecord
  mount_uploaders :images, ImageUploader

  has_many :kitables
  has_many :kits, through: :kitables

  has_many :lookables, as: :lookable
  # has_many :looks, through: :lookables

  belongs_to :category

  has_many :variants, inverse_of: :product
  accepts_nested_attributes_for :variants

  validates_presence_of :title, :price

  class << self
  end
end