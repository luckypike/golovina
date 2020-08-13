class AddCetegoryToKit < ActiveRecord::Migration[6.0]
  def change
    add_reference :kits, :category, foreign_key: true
  end
end
