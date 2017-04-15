class CreateThemables < ActiveRecord::Migration[5.1]
  def change
    create_table :themables do |t|
      t.belongs_to :theme, index: true
      t.references :themable, polymorphic: true, index: true
    end
  end
end
