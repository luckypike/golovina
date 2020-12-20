class AddPaymentToCerts < ActiveRecord::Migration[6.0]
  def change
    add_column :certs, :payment_id, :string
    add_column :certs, :payment_amount, :decimal
    add_column :certs, :payed_at, :datetime
  end
end
