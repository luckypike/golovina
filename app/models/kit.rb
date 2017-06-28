class Kit < ApplicationRecord
  mount_uploaders :images, ImageUploader

  belongs_to :theme
  has_many :kitables, dependent: :destroy
  has_many :products, through: :kitables

  def title
    "#K#{id}"
  end
end
