class Kit < ApplicationRecord
  mount_uploaders :images, ImageUploader

  belongs_to :theme
  has_many :kitables, dependent: :destroy
  has_many :products, through: :kitables

  def title
    products.map(&:title_safe).to_sentence.downcase.upcase_first
  end

  def price
    products.map(&:price).sum
  end
end
