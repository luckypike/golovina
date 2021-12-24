class Themable < ApplicationRecord
  belongs_to :variant
  belongs_to :theme
end
