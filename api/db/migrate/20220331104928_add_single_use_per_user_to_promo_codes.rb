# frozen_string_literal: true

class AddSingleUsePerUserToPromoCodes < ActiveRecord::Migration[6.1]
  def change
    add_column :promo_codes, :single_use_per_user, :boolean, default: false
  end
end
