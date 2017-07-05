class Variant < ApplicationRecord
  scope :themed_by, ->(themes) { where('themes @> any(array[?]::jsonb[])', themes.map(&:to_s)) if themes.present? }

  before_validation :sync_themes_and_category

  belongs_to :product
  belongs_to :color
  belongs_to :category

  validates_uniqueness_of :color_id, scope: [:product_id]


  def sync_themes_and_category
    self.themes = product.themes.map(&:id)
    self.category = product.category
  end
end
