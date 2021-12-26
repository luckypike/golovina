# frozen_string_literal: true

module Api
  class VariantsController < Api::ApplicationController
    before_action :set_variant, only: :edit
    before_action :authorize_variant

    def edit; end

    def update
      cmd = ::Variants::UpdateActor.(variant: @variant, variant_params: params)
      @variant = cmd.result
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
