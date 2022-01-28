# frozen_string_literal: true

class AddFastToDeliveryCities < ActiveRecord::Migration[6.1]
  def change
    add_column :delivery_cities, :fast, :boolean, default: false
  end
end
