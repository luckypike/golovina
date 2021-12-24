class AddFieldsToTheme < ActiveRecord::Migration[5.1]
  def change
    add_column :themes, :image, :string
    add_column :themes, :recency, :timestamp
  end
end
