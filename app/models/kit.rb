class Kit < ApplicationRecord
  mount_uploaders :images, ImageUploader

  belongs_to :theme
  has_many :kitables
  has_many :products, through: :kitables
end
