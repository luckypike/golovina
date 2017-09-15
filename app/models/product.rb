class Product < ApplicationRecord
  enum state: { undef: 0, active: 1, archived: 2 }

  after_save :sync_variants

  has_many :kitables, dependent: :destroy
  has_many :kits, through: :kitables

  belongs_to :category

  has_many :themable, dependent: :destroy
  has_many :themes, through: :themable

  has_many :variants, inverse_of: :product, dependent: :destroy
  accepts_nested_attributes_for :variants, allow_destroy: true

  has_many :images, through: :variants

  validates_presence_of :price, :state, :title

  def title_safe
    title_temp = (self.title.presence || self.id.to_s).strip
    title_temp = title_temp.downcase.upcase_first if title_temp.first == title_temp.first.downcase
    title_temp
  end

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

  def sync_variants
    self.variants.each do |variant|
      variant.themes = self.themes.map(&:id)
      variant.category = self.category
      variant.save
    end
  end

  class << self
  end
end
