# frozen_string_literal: true

module Api
  class Identity < ApplicationRecord
    belongs_to :user
  end
end
