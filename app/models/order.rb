class Order < ApplicationRecord
  enum state: { undef: 0, active: 1, archived: 2 }

  belongs_to :user

  def number
    self.id
  end
end
