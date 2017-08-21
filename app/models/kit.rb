class Kit < ApplicationRecord
  belongs_to :theme
  has_many :kitables, dependent: :destroy
  has_many :products, through: :kitables

  has_many :images, as: :imagable, dependent: :destroy
  accepts_nested_attributes_for :images

  # validates_presence_of :images
  validate :at_least_one_photo



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

  private
  def at_least_one_photo
    if images.size != 1
      errors.add :base, 'Необходимо загрузить фотографию для образа'
    end
  end
end
