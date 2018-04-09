class Cart < ApplicationRecord
  belongs_to :user
  belongs_to :variant, dependent: :destroy

  validates_presence_of :quantity, :size

  def size_human
    if variant.product.category.get_ancestor == Rails.application.secrets[:men]
      I18n.t("sizes_men.size_#{size}")
    elsif variant.product.category.get_ancestor == Rails.application.secrets[:shoes]
      I18n.t("sizes_shoes.size_#{size}")
    else
      I18n.t("sizes.size_#{size}")
    end
  end
end
