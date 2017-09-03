class Variant < ApplicationRecord
  scope :themed_by, ->(themes) { where('themes @> any(array[?]::jsonb[])', themes.map(&:to_s)) if themes.present? }

  before_validation :sync_themes_and_category

  belongs_to :product
  belongs_to :color
  belongs_to :category

  has_many :images, -> { order(created_at: :asc) }, as: :imagable, dependent: :destroy
  # accepts_nested_attributes_for :images

  validates_uniqueness_of :color_id, scope: [:product_id]


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
end
