class Product < ApplicationRecord
  before_validation :set_category

  mount_uploaders :images, ImageUploader

  has_many :kitables
  has_many :kits, through: :kitables

  belongs_to :category
  belongs_to :kind
  belongs_to :theme

  has_many :variants, inverse_of: :product
  accepts_nested_attributes_for :variants, allow_destroy: true

  validates_presence_of :price

  def title
    "#{kind.title} ##{id}"
  end

  def set_category
    self.category = kind.category if kind
  end

  class << self
  end
end
