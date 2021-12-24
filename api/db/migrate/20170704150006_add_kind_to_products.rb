class AddKindToProducts < ActiveRecord::Migration[5.1]
  def change
    add_reference :products, :kind, foreign_key: true
  end
end
