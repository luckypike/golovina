# frozen_string_literal: true

module Api
  class Product < ApplicationRecord
    belongs_to :category, optional: true
  end
end
