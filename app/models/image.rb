class Image < ApplicationRecord
  mount_uploader :photo, PhotoUploader

  belongs_to :imagable, polymorphic: true, optional: true

  after_initialize do
    self.uuid ||= SecureRandom.uuid
  end

  def weight_or_created
    [weight.to_i.zero? ? 99 : weight, created_at]
  end
end
