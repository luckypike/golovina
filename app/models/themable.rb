class Themable < ApplicationRecord
  belongs_to :product
  belongs_to :theme
end
