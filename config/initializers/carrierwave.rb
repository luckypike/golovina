CarrierWave.configure do |config|
  config.fog_provider = 'fog/aws'
  config.fog_credentials = {
    provider: 'AWS',
    aws_access_key_id: Rails.application.credentials[Rails.env.to_sym][:aws][:access_key_id],
    aws_secret_access_key: Rails.application.credentials[Rails.env.to_sym][:aws][:secret_access_key],
    region: Rails.application.credentials[Rails.env.to_sym][:aws][:region],
  }

  config.fog_directory  = Rails.application.credentials[Rails.env.to_sym][:aws][:directory]
  config.fog_public = true
  config.fog_authenticated_url_expiration = 12.hours
  config.fog_attributes = { cache_control: "public, max-age=#{365.days.to_i}" } # optional, defaults to {}
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

    def optimize
      manipulate! do |img|
        return img unless img.mime_type.match /image\/jpeg/
        img.strip
        img.combine_options do |c|
          c.quality "60"
          c.depth "7"
          c.interlace "plane"
        end
        img
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
