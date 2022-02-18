# frozen_string_literal: true

module Api
  class User < ApplicationRecord
    has_many :orders
  end
end
