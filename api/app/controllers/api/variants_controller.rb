# frozen_string_literal: true

module Api
  class VariantsController < Api::ApplicationController
    before_action :set_variant, only: %i[edit update]
    before_action :authorize_variant

    def new
      product = Product.find_by(id: params[:product_id])
      @variant = Variant.new(product: product, state: :unpub)
    end

    def create
      @cmd = Variants::CreateCmd.call(variant_params: params)
    end

    def edit; end

    def update
      @cmd = Variants::UpdateCmd.call(variant: @variant, variant_params: params)
    end

    private

    def set_variant
      @variant = Variant.find(params[:id])
    end

    def authorize_variant
      authorize @variant || Variant
    end
  end
end
