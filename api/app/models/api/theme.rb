# frozen_string_literal: true

module Api
  class Theme < ApplicationRecord
    # has_many :themables, dependent: :destroy
    # has_many :variants, through: :themables
  end
end
