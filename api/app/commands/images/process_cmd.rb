# frozen_string_literal: true

module Images
  class ProcessCmd < ApplicationCmd
    input :image

    def call
      variant_process(image)
      image.update!(processed: true)
    end

    private

    def variant_process(image)
      return unless image.imagable.is_a?(Variant) || image.imagable.is_a?(Api::Variant)

      variant_image_process(image)
      # TODO: temporary user Api::Variant.find
      VariantProcessJob.perform_later(variant: Api::Variant.find(image.imagable.id))
    end

    def variant_image_process(image)
      image.file.variant(
        resize_to_fill: [210, 280], saver: { quality: 85 }, convert: 'jpg'
      ).processed

      image.file.variant(
        resize_to_fill: [3000, 4000], saver: { quality: 85 }, convert: 'jpg'
      ).processed

      image.file.variant(
        resize_to_fill: [1500, 2000], saver: { quality: 85 }, convert: 'jpg'
      ).processed
    end
  end
end
