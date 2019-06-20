class Notification < ApplicationRecord
  belongs_to :variant
  belongs_to :user
end
