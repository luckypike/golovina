class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :variant

  def price
    variant.product.price_sell * quantity
  end

  def size_human
    if variant.product.category.get_ancestor == Rails.application.secrets[:men]
      I18n.t("sizes_men.size_#{size}")
    else
      I18n.t("sizes.size_#{size}")
    end
  end
end
