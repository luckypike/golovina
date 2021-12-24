class Discount < ApplicationRecord
  belongs_to :user, optional: true
end
