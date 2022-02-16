# frozen_string_literal: true

class Subscription < ApplicationRecord
  enum state: { requested: 0, active: 1 }

  validates :email, :first_name, :last_name, :date_of_birth, presence: true
  validates :email, uniqueness: true
end
