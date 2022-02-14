# frozen_string_literal: true

module Variants
  class UpdateCmd < CreateAndUpdateCmd
    input :variant_params
    input :variant
    output :variant

    def call
      params = validate_contract!(UpdateContract, variant_params.compact)
      category_prev_id = variant.category_id

      self.variant = update_variant(variant, params)
      process_variant(variant, category_prev_id)
      process_images(variant)
    end

    private

    def update_variant(variant, params)
      Api::Variant.transaction do
        variant.assign_attributes(params.except(:product_id, :images))
        validate_and_save(variant)
        save_images(variant, params[:images])
        variant
      end
    end
  end
end
