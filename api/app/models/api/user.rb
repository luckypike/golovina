# frozen_string_literal: true

module Api
  class User < ApplicationRecord
    has_many :orders, dependent: :restrict_with_exception
  end
end
