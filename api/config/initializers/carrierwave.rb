# frozen_string_literal: true

CarrierWave.configure do |config|
  config.fog_credentials = {
    provider: "AWS",
    aws_access_key_id: ENV.fetch("aws_access_key_id", nil),
    aws_secret_access_key: ENV.fetch("aws_secret_access_key", nil),
    endpoint: ENV.fetch("aws_endpoint", nil)
  }

  config.fog_directory = ENV.fetch("aws_bucket", nil)
  config.fog_public = true
  config.fog_authenticated_url_expiration = 12.hours
  config.fog_attributes = { cache_control: "public, max-age=#{365.days.to_i}" }
end

module CarrierWave
  module MiniMagick
    def quality(percentage)
      manipulate! do |img|
        img.quality(percentage.to_s)
        img = yield(img) if block_given?
        img
      end
    end

    def gray
      manipulate! do |img|
        return img unless img.mime_type.include?("image/jpeg")

        img.combine_options do |c|
          c.fuzz "2%"
          c.fill "#f8f8f8"
          c.opaque "white"
        end
        img
      end
    end

    def optimize
      manipulate! do |img|
        return img unless img.mime_type.include?("image/jpeg")

        img.strip
        img.combine_options do |c|
          c.quality "80"
          c.depth "8"
          c.interlace "plane"
        end
        img
      end
    end

    def rotate_according_to_exif
      manipulate! do |img|
        img.tap(&:auto_orient)
      end
    end

    def optimize_slide(quality)
      manipulate! do |img|
        return img unless img.mime_type.include?("image/jpeg")

        img.strip
        img.combine_options do |c|
          c.quality quality.to_s
          c.depth "7"
          c.interlace "plane"
        end
        img
      end
    end
  end
end
