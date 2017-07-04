class AddThemeToProducts < ActiveRecord::Migration[5.1]
  def change
    add_reference :products, :theme, foreign_key: true
  end
end
