# frozen_string_literal: true

class AddStateIndexToOrders < ActiveRecord::Migration[6.1]
  def change
    add_index(:orders, :state)
  end
end
