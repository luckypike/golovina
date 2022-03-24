# frozen_string_literal: true

class AddPhoneCodeToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :phone_code, :string
  end
end
