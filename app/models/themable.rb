class Themable < ApplicationRecord
  belongs_to :theme
  belongs_to :themable, polymorphic: true
end
