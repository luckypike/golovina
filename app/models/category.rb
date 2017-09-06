require "babosa"

class Category < ApplicationRecord
  extend FriendlyId

  validates_presence_of :slug
  validates_uniqueness_of :slug

  friendly_id :title, use: :slugged

  has_many :products

  belongs_to :parent_category, class_name: 'Category'
  has_many :categories, class_name: "Category", foreign_key: "parent_category_id"

  def normalize_friendly_id(input)
    input.to_s.to_slug.normalize(transliterations: :russian).to_s
  end
end
