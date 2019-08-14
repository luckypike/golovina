class AddUserToRefunds < ActiveRecord::Migration[5.2]
  def change
    add_reference :refunds, :user, foreign_key: true
    add_reference :refunds, :order, foreign_key: true
  end
end
