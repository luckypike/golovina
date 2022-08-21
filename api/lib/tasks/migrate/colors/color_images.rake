# frozen_string_literal: true

require "open-uri"

namespace :migrate do # rubocop:disable Metrics/BlockLength
  namespace :colors do # rubocop:disable Metrics/BlockLength
    task color_images: :environment do
      s3 = Aws::S3::Client.new(
        access_key_id: Figaro.env.s3_access_key_id,
        secret_access_key: Figaro.env.s3_secret_access_key,
        region: "none",
        endpoint: Figaro.env.s3_endpoint
      )

      Color.where.not(image: nil).each do |color|
        key = "colors/#{SecureRandom.uuid}"
        image = begin
          MiniMagick::Image.open(color.image.url)
        rescue StandardError
          nil
        end

        next unless image

        image.format("webp")
        color.update(color_image: key)
        pp key

        s3.put_object(
          {
            body: open(image.path).read, # rubocop:disable Security/Open
            bucket: Figaro.env.s3_bucket,
            key: key
          }
        )
      end
    end
  end
end
