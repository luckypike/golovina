class CreateRefunds < ActiveRecord::Migration[5.2]
  def change
    create_table :refunds do |t|
      t.integer :state
      t.integer :reason
      t.text :detail

      t.timestamps
    end
  end
end
