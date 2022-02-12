# frozen_string_literal: true

module Api
  class Themable < ApplicationRecord
    belongs_to :variant
    belongs_to :theme
  end
end
