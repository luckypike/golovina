class Availability < ApplicationRecord
  belongs_to :variant
  belongs_to :size
end
