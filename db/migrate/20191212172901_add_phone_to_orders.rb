class AddPhoneToOrders < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :phone, :string

    reversible do |dir|
      dir.up do
        execute <<-SQL
          UPDATE orders o
          SET phone = u.phone
          FROM users u
          WHERE u.id = o.user_id
        SQL
      end
    end
  end
end
