class AddTitleShortToThemes < ActiveRecord::Migration[5.1]
  def change
    add_column :themes, :title_short, :string
  end
end
