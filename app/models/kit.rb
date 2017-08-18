class Kit < ApplicationRecord
  belongs_to :theme
  has_many :kitables, dependent: :destroy
  has_many :products, through: :kitables

  has_many :images, as: :imagable, dependent: :destroy
  accepts_nested_attributes_for :images

  def title_safe
    self.title.presence || products.map(&:title_safe).to_sentence.downcase.upcase_first
  end

  def price
    products.map(&:price).sum
  end

  def entity_created_at
    created_at
  end

  def photo
    images[0].photo.presence || nil
  end
end
