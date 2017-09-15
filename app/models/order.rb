class Order < ApplicationRecord
  enum state: { undef: 0, active: 1, archived: 2 }

  belongs_to :user

  has_many :order_items

  # accepts_nested_attributes_for :user

  def number
    self.id
  end
end
