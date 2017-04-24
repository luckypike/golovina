class Kit < ApplicationRecord
  mount_uploaders :images, ImageUploader

  has_many :kitables
  has_many :products, through: :kitables
end
