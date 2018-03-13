class Kit < ApplicationRecord
  enum state: { undef: 0, active: 1, archived: 2 }

  belongs_to :theme
  has_many :kitables, dependent: :destroy
  has_many :variants, through: :kitables

  has_many :images, as: :imagable, dependent: :destroy
  accepts_nested_attributes_for :images

  validates_presence_of :state
  # validate :at_least_one_photo



  def title_safe
    self.title.presence || variants.map(&:product).map(&:title_safe).to_sentence.downcase.upcase_first
  end

  def price
    variants.map(&:product).flatten.map(&:price).sum
  end

  def price_sell
    variants.map(&:product).flatten.map(&:price_sell).sum
  end

  def entity_created_at
    created_at
  end

  def photo
    images[0].photo.presence || nil
  end

  def active?
    true
  end

  private
  def at_least_one_photo
    if images.size != 1
      errors.add :base, 'Необходимо загрузить фотографию для образа'
    end
  end
end
