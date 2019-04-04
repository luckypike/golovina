class Availability < ApplicationRecord
  belongs_to :variant
  belongs_to :size

  def active?
    count > 0
  end
end
