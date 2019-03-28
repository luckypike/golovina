class Variant < ApplicationRecord
  enum state: { active: 1, archived: 2}

  default_scope { includes(:images, { product: :category }) }

  before_validation :parse_image_ids

  before_save :cache_sizes
  after_save :check_category

  belongs_to :product
  belongs_to :color
  has_many :availabilities
  has_many :sizes, through: :availabilities

  has_many :images, as: :imagable, dependent: :destroy
  accepts_nested_attributes_for :images

  validates_uniqueness_of :color_id, scope: [:product_id]

  has_many :wishlists, dependent: :destroy
  has_many :carts, dependent: :destroy

  has_many :kitables, dependent: :destroy
  has_many :kits, through: :kitables

  validates_presence_of :price, :sizes, :state

  include ActionView::Helpers::NumberHelper
  include ProductsHelper

  def sync_themes_and_category
    # self.themes = product.themes.map(&:id)
    # self.category = product.category
  end

  def variant_price
    price? ? price : (product.price? ? product.price : 0)
  end

  def variant_price_last
    price_last? ? price_last : product.price_last
  end

  def variant_desc
    desc? ? desc : product.desc
  end

  def variant_comp
    comp? ? comp : product.comp
  end

  def price_sell
    self.variant_price_last.presence || self.variant_price
  end

  def discount_price(discount)
    self.price_sell - self.price_sell * discount
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

  def in_order?
    OrderItem.where(variant_id: self).any?
  end

  def purchasable size, quantity
    sizes[size.to_s].to_i >= quantity ? true : false
  end

  def check_category
    product.category.check
  end

  def cache_sizes
    self.sizes_cache = sizes_active
  end
end
