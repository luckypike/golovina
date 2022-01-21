# frozen_string_literal: true

module Api
  class Image < ApplicationRecord
    belongs_to :imagable, polymorphic: true, optional: true

    validates :uuid, :file, presence: true

    scope :active_and_ordered, -> { where(active: true, processed: true).order(weight: :asc) }

    has_one_attached :file

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

    # TODO: Remove this bypass
    def weight_or_created
      weight
    end

    def photo
      OpenStruct.new(thumb: OpenStruct.new(url: thumb_url))
    end
  end
end
