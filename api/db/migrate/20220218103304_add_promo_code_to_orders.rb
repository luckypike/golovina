# frozen_string_literal: true

class AddPromoCodeToOrders < ActiveRecord::Migration[6.1]
  def change
    add_reference :orders, :promo_code, null: true, foreign_key: true
  end
end
