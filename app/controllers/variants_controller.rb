class VariantsController < ApplicationController
  # before_action :set_product_and_variants, only: [:create, :index, :update, :destroy]
  before_action :set_variant, only: [:update, :destroy]


  # def index
  #   @product = Product.find(params[:product_id])
  #   @variant = Variant.new(product: @product)
  #   @variant.images.build
  #   # @variant.color = Color.find(1)
  # end

  def update
    authorize @variant

    if @variant.update(variant_params)
      head :ok
    else
      render text: "\"#{@variant.errors.full_messages.first}\"", status: 422
    end
  end

  # def create
  #   @variant = Variant.new(variant_params)
  #   authorize @variant
  #   # @variant.product = Product.find(params[:product_id])

  #   if @variant.save!
  #     redirect_to @variant.product, notice: 'Variant was successfully created.'
  #   else
  #     render :index
  #   end
  # end

  private
  def set_variant
    @variant = Variant.find(params[:id])
  end

  def variant_params
    params.require(:variant).permit(sizes: [])
  end
end
