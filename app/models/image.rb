class Image < ApplicationRecord
  mount_uploader :photo, PhotoUploader

  belongs_to :imagable, polymorphic: true, optional: true

  after_initialize do
    self.uuid ||= SecureRandom.uuid
  end
end
