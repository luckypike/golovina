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
  end
end


