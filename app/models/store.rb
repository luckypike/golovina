class Store < ApplicationRecord
  default_scope { order(:id) }
end
