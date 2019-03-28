class Size < ApplicationRecord
  belongs_to :sizes_group
  has_many :availabilities, dependent: :destroy
end
