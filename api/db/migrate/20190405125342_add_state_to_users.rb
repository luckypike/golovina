class AddStateToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :state, :integer, default: 0

    reversible do |dir|
      dir.up do
        execute <<-SQL
          UPDATE users SET state = 1 WHERE phone IS NOT NULL
        SQL
      end
    end
  end
end
