class Variant < ApplicationRecord
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  default_scope do
    includes(
      :images,
      product: %i[translations category]
    ).order(pinned: :desc, created_at: :desc)
  end

  scope :available, -> { includes(:availabilities).where(availabilities: { id: nil }) }
  scope :not_archived, -> { where.not(state: :archived) }
  # scope :visible, -> { Current.user&.is_editor? && where(show: true) }

  enum state: { unpub: 0, active: 1, archived: 2 }

  belongs_to :product, inverse_of: :variants
  accepts_nested_attributes_for :product

  has_one :category, through: :product

  belongs_to :color

  has_many :images, as: :imagable, dependent: :destroy
  accepts_nested_attributes_for :images

  has_many :availabilities, dependent: :destroy
  has_many :sizes, through: :availabilities

  validates :color, uniqueness: { scope: :product_id }
  # validates :code, uniqueness: true, unless: -> { code.blank? }
  # validates :price, presence: true, if: -> { active? }

  before_save :default_values

  after_save :cache_sizes
  # after_save :check_state
  after_save :check_category
  after_save :check_notifications

  translates :desc, :comp, :title
  globalize_accessors locales: I18n.available_locales, attributes: %i[desc comp title]

  # --------------

  accepts_nested_attributes_for :availabilities, allow_destroy: true

  has_many :wishlists, dependent: :destroy
  has_many :carts, dependent: :destroy
  has_many :order_items, dependent: :destroy

  has_many :kitables, dependent: :destroy
  has_many :kits, through: :kitables
  has_many :notifications, dependent: :destroy

  settings do
    mappings dynamic: false do
      indexes :desc, fields: {
        ru: { analyzer: :russian, type: :text },
        en: { analyzer: :english, type: :text }
      }

      indexes :product, type: 'object' do
        indexes :title, fields: {
          ru: { analyzer: :russian, type: :text },
          en: { analyzer: :english, type: :text }
        }
      end

      indexes :color, type: 'object' do
        indexes :title, fields: {
          ru: { analyzer: :russian, type: :text },
          en: { analyzer: :english, type: :text }
        }
      end
    end
  end

  include ActionView::Helpers::NumberHelper
  include ProductsHelper

  def available?
    availabilities.active.any? && price_sell.present?
  end

  def price_sell
    price_last.presence || price
  end

  def discount_price(discount)
    price_sell - price_sell * discount
  end

  def entity_created_at
    product.created_at
  end

  def photo
    images[0].photo.presence || nil
  end

  def title_last
    (title.presence || product.title).strip
  end

  def in_wishlist(user)
    wishlists.where(user: user).any?
  end

  def in_notification(user)
    notifications.where(user: user).any?
  end

  def in_order?
    OrderItem.where(variant_id: self).any?
  end

  # TODO: переписать этот метод чтобы для более няшного кода
  def decrease item
    availability = availabilities.where(store_id: 1, size_id: item.size_id).where('quantity > ?', 0).first
    availability = availabilities.where.not(store_id: 1).where(size_id: item.size_id).where('quantity > ?', 0).first unless availability

    if availability
      if item.quantity > availability.quantity
        diff = item.quantity - availability.quantity
        availability.quantity = 0
        availability.save
        availability = availabilities.where.not(store_id: 1).where(size_id: item.size_id).where('quantity > ?', 0).first
        availability.quantity -= diff
        availability.save
      else
        availability.quantity -= item.quantity
        availability.save
      end
    else
      # TODO: добавить действие если произошел казус что оба заказа оплачивали одновременно
    end
  end

  # def check_state
  #   if soon && availabilities.all? { |a| !a.active? }
  #     update_column(:state, :soon)
  #   elsif !soon && availabilities.all? { |a| !a.active? }
  #     update_column(:state, :archived)
  #   else
  #     update_column(:state, :active)
  #   end
  # end

  def check_notifications
    if active? && available?
      notifications.each do |notification|
        NotifyMailer.notify_mailer(notification.user.email, notification.variant).deliver_later
        notification.destroy
      end
    end
  end

  def images?
    images.size.positive?
  end

  def product_attributes=(attributes)
    self.product = Product.find_by(id: attributes[:id])
    super
  end

  def images_attributes=(attributes)
    self.images = Image.where(id: attributes.map{ |attribute| attribute[:id] })
    super
  end

  private

  def default_values
    self.state = state.presence || :unpub
  end

  def check_category
    Category.find(product.category_id_before_last_save).check_variants_counter if product.category_id_before_last_save
    product.category.check_variants_counter
  end

  def cache_sizes
    update_column(:sizes_cache, sizes.map(&:id))
  end

  def as_indexed_json(_options = {})
    as_json(
      only: :desc,
      include: {
        product: { only: :title },
        color: { only: :title}
      }
    )
  end

end
