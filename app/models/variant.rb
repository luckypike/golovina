class Variant < ApplicationRecord
  enum state: { active: 1, archived: 2, out: 3 }

  scope :themed_by, ->(themes) { where('variants.themes @> any(array[?]::jsonb[])', themes.map(&:to_s)) if themes.present? }
  scope :sized_by, ->(sizes) { where('variants.sizes ?| array[:sizes]', { sizes: sizes.map(&:to_s) }) if sizes.present? }

  before_validation :sync_themes_and_category

  belongs_to :product
  belongs_to :color
  belongs_to :category

  has_many :images, -> { order(weight: :asc, created_at: :asc) }, as: :imagable, dependent: :destroy

  validates_uniqueness_of :color_id, scope: [:product_id]

  has_many :wishlists, dependent: :destroy
  has_many :carts, dependent: :destroy

  has_many :kitables, dependent: :destroy
  has_many :kits, through: :kitables


  def sync_themes_and_category
    self.themes = product.themes.map(&:id)
    self.category = product.category
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
end
