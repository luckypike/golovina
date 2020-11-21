class Cert < ApplicationRecord
  enum discount_type: { flat: 0, percent: 1 }, _prefix: true

  belongs_to :user

  validates :discount, :discount_type, :amount, presence: true
  validates :code, presence: true, uniqueness: true
  # validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }

  accepts_nested_attributes_for :user, update_only: true
end
