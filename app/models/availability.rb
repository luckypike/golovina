class Availability < ApplicationRecord
  belongs_to :variant
  belongs_to :size
  belongs_to :store

  def active?
    count > 0
  end
end
