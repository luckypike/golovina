CarrierWave.configure do |config|
  config.fog_credentials = {
    provider: 'AWS',
    aws_access_key_id: Rails.application.credentials.dig(Rails.env.to_sym, :aws, :access_key_id),
    aws_secret_access_key: Rails.application.credentials.dig(Rails.env.to_sym, :aws, :secret_access_key),
    endpoint: Rails.application.credentials.dig(Rails.env.to_sym, :aws, :endpoint)
  }

  config.fog_directory = Rails.application.credentials.dig(Rails.env.to_sym, :aws, :bucket)
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
        return img unless img.mime_type.match /image\/jpeg/
        img.combine_options do |c|
          c.fuzz '2%'
          c.fill '#c8c8c8'
          c.opaque 'white'
        end
        img
      end
    end

    def optimize
      manipulate! do |img|
        return img unless img.mime_type.match /image\/jpeg/
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
        return img unless img.mime_type.match /image\/jpeg/
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
