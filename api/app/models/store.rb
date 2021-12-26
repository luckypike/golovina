class Store < ApplicationRecord
  default_scope { order(:id) }

  class << self
    def factory
      find(2)
    end
  end
end
