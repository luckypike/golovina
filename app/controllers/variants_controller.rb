class VariantsController < ApplicationController
  before_action :set_variant, only: [:update, :destroy, :images]
  before_action :set_user, only: [:wishlist, :cart]


  def wishlist
    variant = Variant.includes(:product).find(params[:variant_id])
    authorize variant

    wishlist = Wishlist.find_or_initialize_by(user: current_user, variant: variant)
    wishlist.persisted? ? wishlist.destroy : wishlist.save

    respond_to do |format|
      format.html { redirect_to product_path(variant.product, anchor: variant.id) }
      format.js { render plain: wishlist.persisted? }
    end
  end

  def cart
    variant = Variant.includes(:product).find(params[:variant_id])
    authorize variant

    if variant.sizes.reject(&:blank?).include?(params[:size]) && variant.product.active?
      cart = Cart.find_or_initialize_by(user: current_user, variant: variant, size: params[:size])
      cart.quantity += 1 if cart.persisted?
      cart.save
    end

    respond_to do |format|
      format.html { redirect_to product_path(variant.product, anchor: variant.id) }
      format.js { render plain: Cart.where(user: current_user).map(&:quantity).sum }
    end
  end

  def update
    authorize @variant

    if @variant.update(variant_params)
      head :ok
    else
      render text: "\"#{@variant.errors.full_messages.first}\"", status: 422
    end
  end

  def images
    authorize @variant

    render json: { images: @variant.images, wishlist: @variant.in_wishlist(current_user), out_of_stock: @variant.out_of_stock  }
  end

  def create
    @variant = Variant.new(variant_params)
    authorize @variant

    if @variant.save
      redirect_to [:variants, @variant.product], notice: 'Variant was successfully created.'
    else
      @product = @variant.product
      render 'products/variants'
    end
  end

  def destroy
    authorize @variant

    @variant.destroy

    redirect_to [:variants, @variant.product]
  end

  private
  def set_variant
    @variant = Variant.find(params[:id])
  end

  def variant_params
    params.require(:variant).permit(:product_id, :color_id, :out_of_stock, sizes: [])
  end
end
