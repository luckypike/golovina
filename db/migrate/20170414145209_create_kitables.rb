class CreateKitables < ActiveRecord::Migration[5.1]
  def change
    create_table :kitables do |t|
      t.belongs_to :kit, index: true
      t.belongs_to :product, index: true
    end
  end
end
