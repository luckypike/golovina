# frozen_string_literal: true

module Variants
  class CreateCmd < CreateAndUpdateCmd
    input :variant_params
    output :variant

    def call
      params = validate_contract!(CreateContract, variant_params)

      self.variant = create_variant(params)
      process_variant(variant)
    end

    private

    def create_variant(params)
      Api::Variant.transaction do
        variant = build_variant(params.except(:images))
        validate_and_save(variant)
        save_images(variant, params[:images])
        variant
      end
    end

    def build_variant(params)
      product = find_or_create_product(params[:product_id])
      Api::Variant.new(params.merge(product_id: product.id))
    end

    def find_or_create_product(id)
      Api::Product.where(id: id).first_or_create!
    end
  end
end
