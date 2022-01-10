# frozen_string_literal: true

module Api
  class Image < ApplicationRecord
    has_one_attached :file
    belongs_to :imagable, polymorphic: true, optional: true

    validates :uuid, :file, presence: true

    # TODO: use named variants after upgrade to 7.x
    def thumb_url
      key = file.variant(
        resize_to_fill: [1500, 2000],
        saver: { quality: 85 },
        convert: 'jpg'
      ).processed.key

      ENV.fetch('S3_URL', '/') + "/#{key}.jpg"
    end

    def large_url
      key = file.variant(
        resize_to_fill: [3000, 4000],
        saver: { quality: 85 },
        convert: 'jpg'
      ).processed.key

      ENV.fetch('S3_URL', '/') + "/#{key}.jpg"
    end
  end
end
