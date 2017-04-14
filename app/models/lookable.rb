class Lookable < ApplicationRecord
  belongs_to :look
  belongs_to :lookable, polymorphic: true
end
