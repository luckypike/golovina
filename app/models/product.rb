class Product < ApplicationRecord
  enum state: { undef: 0, active: 1, archived: 2 }

  # before_validation :set_category

  has_many :kitables, dependent: :destroy
  has_many :kits, through: :kitables

  belongs_to :category

  has_many :themable, dependent: :destroy
  has_many :themes, through: :themable

  has_many :variants, inverse_of: :product, dependent: :destroy
  accepts_nested_attributes_for :variants, allow_destroy: true

  validates_presence_of :price, :state, :title

  def title_safe
    (self.title.presence || self.id.to_s).downcase.upcase_first
  end

  # def set_category
  #   self.category = kind.category if kind
  # end

  def photo
    if variants.size > 0 && variants.first.images[0]
      variants.first.images[0].photo
    else
      nil
    end
  end

  def sizes
    variants.first.sizes
  end

  class << self
  end
end
