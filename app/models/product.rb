class Product < ApplicationRecord
  enum state: { undef: 0, active: 1, archived: 2 }

  before_validation :set_category

  has_many :kitables
  has_many :kits, through: :kitables

  belongs_to :category
  belongs_to :kind

  has_many :themable
  has_many :themes, through: :themable

  has_many :variants, inverse_of: :product
  accepts_nested_attributes_for :variants, allow_destroy: true

  validates_presence_of :price, :state

  def title_auto
    "#{kind.title} ##{id}"
  end

  def title_safe
    (self.title.presence || title_auto).downcase.upcase_first
  end

  def set_category
    self.category = kind.category if kind
  end

  def photo
    variants.first.images[0].photo.presence || nil
  end

  def sizes
    variants.first.sizes
  end

  class << self
  end
end
