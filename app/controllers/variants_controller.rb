class VariantsController < ApplicationController
  before_action :set_variant, only: [:update, :destroy, :images]
  before_action :set_user, only: [:wishlist, :cart]

  def index
    authorize Variant

    if params[:kit_id].present?
      @selected = Variant.includes(:product, :images, :color, :kitables).where(id: params[:selected], kitables: { kit_id: params[:kit_id] }).sort_by{ |v| v.kitables.first.id }
    else
      @selected = Variant.includes(:product, :images, :color).where(id: params[:selected])
    end

    @variants = Variant.includes(:product, :images, :color).where.not(id: @selected.map(&:id)).order(created_at: :desc).limit(params[:q].present? ? nil : 12).select{ |v| v.title.downcase.include? params[:q].downcase }


    respond_to do |format|
      format.json
    end
  end

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

    sleep 1

    if variant.sizes_active.include?(params[:size]) && variant.active?
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

    render json: { images: @variant.images.sort_by{ |i| [(i.weight.to_i.zero? ? 99 : i.weight), i.created_at] }, wishlist: @variant.in_wishlist(current_user), out_of_stock: @variant.out_of_stock, variant_state: @variant.state }
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
    params.require(:variant).permit(:product_id, :color_id, :out_of_stock, :state, sizes: [], :created_at)
  end
end
