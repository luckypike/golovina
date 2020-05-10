class UserAddress < ApplicationRecord
  enum delivery_option: { door: 1, storage: 2 }

  belongs_to :user
  belongs_to :delivery_city, optional: true

  validates :street, :house, :appartment, presence: true, if: -> { door? || !delivery_city }
  validates :delivery_option, presence: true, if: :delivery_city
  validates :country, :city, presence: true, unless: :delivery_city
end
