# frozen_string_literal: true

class Token < ApplicationRecord
  validates :key, :value, presence: true
end
