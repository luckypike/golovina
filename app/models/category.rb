require "babosa"

class Category < ApplicationRecord
  enum state: { inactive: 0, active: 1 }

  extend FriendlyId

  validates_presence_of :slug, :state, :title
  validates_uniqueness_of :slug

  friendly_id :title, use: :slugged

  has_many :products
  has_many :variants, through: :products

  belongs_to :parent_category, class_name: 'Category', optional: true
  has_many :categories, -> { order(weight: :asc) }, class_name: "Category", foreign_key: "parent_category_id"

  has_many :images, as: :imagable, dependent: :destroy
  accepts_nested_attributes_for :images

  def normalize_friendly_id(input)
    input.to_s.to_slug.normalize(transliterations: :russian).to_s
  end

  def check
    update_attribute(:variants_counter, variants.active.size)
  end
end
