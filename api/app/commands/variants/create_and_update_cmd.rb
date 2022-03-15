# frozen_string_literal: true

module Variants
  class CreateAndUpdateCmd < ApplicationCmd
    protected

    def process_variant(variant, category_prev_id = nil)
      CategoryProcessJob.perform_later(category: Api::Category.find(category_prev_id)) if category_prev_id
      VariantProcessJob.perform_later(variant: variant)
    end

    def process_images(variant)
      Api::Image.where(imagable_type: "Variant", imagable_id: variant.id).each do |image|
        ImageProcessJob.perform_later(image: image)
      end
    end

    def validate_and_save(variant)
      validate_entity!(variant)
      variant.save!
    end

    def save_images(variant, images_params)
      images_params&.each do |params|
        image = Api::Image.find(params[:id])
        image.assign_attributes(params.except(:id))
        image.processed = false
        image.imagable_type = "Variant"
        image.imagable_id = variant.id
        validate_entity!(image)
        image.save!
      end
    end
  end
end
