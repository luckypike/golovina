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

  def normalize_friendly_id(input)
    input.to_s.to_slug.normalize(transliterations: :russian).to_s
  end

  def show?
    active? && !variants_counter.blank? && variants_counter > 0
  end

  # def check_empty
  #   if ((categories.size > 0 && categories.select(&:show?).size == 0) || categories.size == 0) && variants.size == 0
  #     update_attribute(:empty, true)
  #   else
  #     update_attribute(:empty, false)
  #   end
  #
  #   if parent_category
  #     parent_category.check_empty
  #   end
  # end

  def variants_count
    variants_counter.presence || (categories.map(&:variants_count).sum + variants.where(state: [:active, :out]).size)
  end

  def check_variants
    self.variants_counter = nil
    update({variants_counter: variants_count})

    if parent_category
      parent_category.check_variants
    end
  end

  class << self
    def tree
      tree = []
      categories = where(parent_category: nil).order(id: :asc)
      categories.each do |category|
        tree << category
        if category.categories.size > 0
          category.categories.each do |cc|
            cc.title = '- ' + cc.title
            tree << cc
            if cc.categories.size > 0
              cc.categories.each do |ccc|
                ccc.title = '— ' + ccc.title
                tree << ccc
              end
            end
          end
        end
      end
      tree
    end
  end
end
