class Post < ApplicationRecord
  has_many :images, as: :imagable, dependent: :destroy
  accepts_nested_attributes_for :images
end
