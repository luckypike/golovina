class Image < ApplicationRecord
  mount_uploader :photo, PhotoUploader

  belongs_to :imagable, polymorphic: true, optional: true

  after_initialize do
    self.uuid ||= SecureRandom.uuid
  end

  def weight_or_created
    [weight.to_i.zero? ? 99 : weight, created_at]
  end

  class << self
    def variants
      Variant.unscoped.includes(:images).joins(:images)
        .where.not(images: { id: nil }).limit(3)
    end

    def category(category)
      Rails.cache.fetch("images/category/#{category.id}", expires_in: 1.hour) do
        variants.joins(:product).where(products: { category_id: category.id })
      end
    end

    def latest
      Rails.cache.fetch('images/latest', expires_in: 1.hour) do
        variants.where(latest: true).map(&:images).flatten
      end
    end

    def sale
      Rails.cache.fetch('images/sale', expires_in: 1.hour) do
        variants.where(sale: true).map(&:images).flatten
      end
    end

    def premium
      Rails.cache.fetch('images/premium', expires_in: 1.hour) do
        variants.where(premium: true).map(&:images).flatten
      end
    end

    def morning
      Rails.cache.fetch('images/morning', expires_in: 1.hour) do
        variants.where(morning: true).map(&:images).flatten
      end
    end

    def stayhome
      Rails.cache.fetch('images/stayhome', expires_in: 1.hour) do
        variants.where(stayhome: true).map(&:images).flatten
      end
    end

    def overall
      Rails.cache.fetch('images/overall', expires_in: 1.hour) do
        variants.map(&:images).flatten
      end
    end
  end
end
