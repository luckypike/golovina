# frozen_string_literal: true

class PromoCode < ApplicationRecord
  enum state: { inactive: 0, active: 1 }, _prefix: true
  enum discount: { amount: 1, percentage: 2 }, _prefix: true

  validates :state, :value, :discount, presence: true
  validates :title, uniqueness: true, presence: true

  def apply(amount)
    temp =
      if discount_amount?
        apply_amount(amount)
      elsif discount_percentage?
        apply_percentage(amount)
      else
        amount
      end

    corrent_discount(amount, temp)
  end

  private

  def corrent_discount(amount, temp)
    temp = 0 if temp.negative?
    temp = amount if temp > amount
    temp
  end

  def apply_amount(amount)
    amount - value
  end

  def apply_percentage(amount)
    amount - (amount * value)
  end
end
