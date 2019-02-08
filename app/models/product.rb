class Product < ApplicationRecord
  # enum state: { undef: 0, active: 1, archived: 2 }

  after_save :sync_variants
  # after_save :check_category

  belongs_to :category

  has_many :themable, dependent: :destroy
  has_many :themes, through: :themable

  has_many :variants, inverse_of: :product, dependent: :destroy
  accepts_nested_attributes_for :variants, reject_if: :all_blank, allow_destroy: true

  has_many :images, through: :variants

  has_many :similarables, dependent: :destroy
  has_many :similar_products, class_name: 'Product', through: :similarables

  has_many :kits, through: :variants

  validates_presence_of :title

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

  def price
    variants.first.price
  end

  def price_sell
    self.price_last.presence || self.price
  end

  def discount_price(discount)
    self.price_sell - self.price_sell * discount
  end

  def sizes
    variants.first.sizes
  end

  def avail_sizes
    if self.category.get_ancestor == Rails.application.secrets[:men]
      Size.where(sizes_group_id: 2).map{|s| [s.id, s.size]}.to_h
    elsif self.category.get_ancestor == Rails.application.secrets[:shoes]
      Size.where(sizes_group_id: 3).map{|s| [s.id, s.size]}.to_h
    else
      Size.where(sizes_group_id: 1).map{|s| [s.id, s.size]}.to_h
    end
  end

  def sync_variants
    self.variants.each do |variant|
      variant.update_attribute(:themes, self.themes.map(&:id))
      variant.update_attribute(:category, self.category)
    end
  end

  def purchasable
    self.variants.active.any?{|variant| variant.available} ? true : false
  end

  def in_order?
    variants.any?{|variant| variant.in_order?}
  end

  # def state
  # end

  # def check_empty
  #   if variants.where(state: [:active, :out]).size == 0
  #     archived!
  #   else
  #     active!
  #   end
  # end
end
