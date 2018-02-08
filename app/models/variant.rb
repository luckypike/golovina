class Variant < ApplicationRecord
  enum state: { active: 1, archived: 2, out: 3 }

  scope :themed_by, ->(themes) { where('variants.themes @> any(array[?]::jsonb[])', themes.map(&:to_s)) if themes.present? }
  scope :sized_by, ->(sizes) { where('variants.sizes ?| array[:sizes]', { sizes: sizes.map(&:to_s) }) if sizes.present? }

  before_validation :parse_image_ids
  before_validation :set_size
  before_validation :sync_themes_and_category
  # after_save :check_product

  belongs_to :product
  belongs_to :color
  belongs_to :category

  has_many :images, as: :imagable, dependent: :destroy
  accepts_nested_attributes_for :images

  validates_uniqueness_of :color_id, scope: [:product_id]

  has_many :wishlists, dependent: :destroy
  has_many :carts, dependent: :destroy

  has_many :kitables, dependent: :destroy
  has_many :kits, through: :kitables

  validates_presence_of :sizes, :state

  def sync_themes_and_category
    self.themes = product.themes.map(&:id)
    self.category = product.category
  end

  def parse_image_ids
    p self
  end

  def entity_created_at
      product.created_at
  end

  def photo
    images[0].photo.presence || nil
  end

  def title
    "#{self.product.title_safe} (#{self.color.title})"
  end

  def in_wishlist user
    Wishlist.where(user: user, variant: self).any?
  end

  def sizes_clean
    sizes.reject(&:blank?)
  end

  def set_size
    self.sizes = nil if sizes_clean.size == 0
  end

  def check_product
    product.check_empty
  end
end
