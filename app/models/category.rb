require "babosa"

class Category < ApplicationRecord
  extend FriendlyId

  validates_presence_of :slug
  validates_uniqueness_of :slug

  friendly_id :title, use: :slugged

  has_many :products

  belongs_to :parent_category, class_name: 'Category', optional: true
  has_many :categories, class_name: "Category", foreign_key: "parent_category_id"

  def normalize_friendly_id(input)
    input.to_s.to_slug.normalize(transliterations: :russian).to_s
  end

  class << self
    def tree
      tree = []
      categories = where(parent_category: nil).order(id: :asc)
      categories.each do |category|
        tree << category
        if category.categories.size > 0
          category.categories.each do |category_category|
            category_category.title = '-- ' + category_category.title
            tree << category_category
          end
        end
      end
      tree
    end
  end
end
