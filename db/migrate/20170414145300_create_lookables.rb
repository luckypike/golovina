class CreateLookables < ActiveRecord::Migration[5.1]
  def change
    create_table :lookables do |t|
      t.belongs_to :look, index: true
      t.references :lookable, polymorphic: true, index: true
    end
  end
end
