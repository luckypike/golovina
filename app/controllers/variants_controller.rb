class VariantsController < ApplicationController
  before_action :set_product_and_variants, only: [:create, :index, :update, :destroy]
  before_action :set_variant, only: [:show, :destroy]


  def index
    @product = Product.find(params[:product_id])
    @variant = Variant.new(product: @product)
  end

  def create
    @variant = Variant.new(variant_params)
    @variant.product = Product.find(params[:product_id])

    if @variant.save
      redirect_to [@variant.product, :variants], notice: 'Variant was successfully created.'
    else
      render :index
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_variant
      @variant = Variant.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def variant_params
      params.require(:variant).permit(:product_id, :color_id, sizes: [])
    end

    def set_product_and_variants
      @product = Product.find(params[:product_id])
      @variants = @product.variants
    end
end
