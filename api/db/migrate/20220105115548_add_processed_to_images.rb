class AddProcessedToImages < ActiveRecord::Migration[6.1]
  def change
    add_column :images, :processed, :boolean
  end
end
