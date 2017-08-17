class Image < ApplicationRecord
  mount_uploader :photo, PhotoUploader

  belongs_to :imagable, polymorphic: true, optional: true
end
