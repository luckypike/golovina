class Variant < ApplicationRecord
  enum state: { active: 1, archived: 2}

  default_scope { includes(:images, { product: :category }).order(pinned: :desc, created_at: :desc) }

  before_validation :parse_image_ids

  before_save :cache_sizes
  after_save :check_category

  belongs_to :product
  accepts_nested_attributes_for :product, update_only: true

  has_one :category, through: :product
  belongs_to :color
  has_many :availabilities
  has_many :sizes, through: :availabilities
  accepts_nested_attributes_for :availabilities, allow_destroy: true

  has_many :images, as: :imagable, dependent: :destroy
  accepts_nested_attributes_for :images

  validates_uniqueness_of :color_id, scope: [:product_id]

  has_many :wishlists, dependent: :destroy
  has_many :carts, dependent: :destroy

  has_many :kitables, dependent: :destroy
  has_many :kits, through: :kitables

  validates_presence_of :price, :state

  include ActionView::Helpers::NumberHelper
  include ProductsHelper

  def price_sell
    price_last.presence || price
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
    wishlists.where(user: user).any?
  end

  def in_order?
    OrderItem.where(variant_id: self).any?
  end

  # TODO: переписать этот метод чтобы для более няшного кода
  def decrease quantity
    availability = availabilities.where(store_id: 1).where('quantity > ?', 0).first
    availability = availabilities.where.not(store_id: 1).where('quantity > ?', 0).first unless availability

    if availability
      if quantity > availability.quantity
        diff = quantity - availability.quantity
        availability.quantity = 0
        availability.save
        availability = availabilities.where.not(store_id: 1).where('quantity > ?', 0).first
        availability.quantity -= diff
        availability.save
      else
        availability.quantity -= quantity
        availability.save
      end
    else
      # TODO: добавить действие если произошел казус что оба заказа оплачивали одновременно
    end
  end

  def check_category
    Category.find(product.category_id_before_last_save).check if product.category_id_before_last_save
    product.category.check
  end

  def cache_sizes
    self.sizes_cache = sizes.map(&:id)
  end
end
