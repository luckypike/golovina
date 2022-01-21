# frozen_string_literal: true

require 'open-uri'

namespace :migrate do
  namespace :images do
    desc 'Move from CW to AS'
    task file: :environment do
      Image
        .joins('LEFT JOIN variants ON images.imagable_id = variants.id AND images.imagable_type = \'Variant\'')
        .where(variants: { state: [0, 1] }).find_each do |image|
          next unless image.photo.try(:file).exists?

          api_image = Api::Image.find(image.id)
          api_image.file.attach(io: URI.open(image.photo.url), filename: image.photo.filename)
          ImageProcessJob.perform_later(image: api_image)
        end
    end
  end
end
