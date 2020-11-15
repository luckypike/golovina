class Cert < ApplicationRecord
  belongs_to :user

  validates :discount, presence: true
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }

  accepts_nested_attributes_for :user, update_only: true
end
