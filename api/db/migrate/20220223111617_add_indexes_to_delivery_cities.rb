# frozen_string_literal: true

class AddIndexesToDeliveryCities < ActiveRecord::Migration[6.1]
  def change
    add_index :delivery_cities, :fast
    add_index :delivery_cities, :title
  end
end
