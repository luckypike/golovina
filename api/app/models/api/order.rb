# frozen_string_literal: true

module Api
  class Order < ApplicationRecord
    enum state: { cart: 0, paid: 2, archived: 3 }

    has_many :order_items
  end
end
