class VariantsController < ApplicationController
  before_action :set_guest_user, only: %i[wishlist cart]
  before_action :set_variant, only: %i[edit update wishlist cart]
  # before_action :authorize_variant, only: %i[edit update wishlist cart]
  before_action :authorize_variant, except: :show

  def show
    @category = Category.friendly.find(params[:slug])
    @variant = @category.variants.find_by!(id: params[:id])

    authorize @variant

    @variants = policy_scope(@variant.variants.for_variant)
    #   .with_translations(I18n.available_locales)
    #   .includes(:color, availabilities: %i[size store])

    respond_to :html, :json
  end

  def all
    @variants = policy_scope(Variant.for_list)

    respond_to :html, :json
  end

  def list
    authorize Variant

    @variants = Variant.includes(:product, :color).not_archived
    @variants = @variants.select{ |s| s.product.title.downcase.include? params[:q].downcase } if params[:q]

    respond_to :json
  end

  def wishlist
    @wishlist = Wishlist.find_or_initialize_by(user: current_user, variant: @variant)
    @wishlist.persisted? ? @wishlist.destroy : @wishlist.save

    @wishlists = Wishlist.joins(:variant)
      .where(user: current_user, variants: { state: :active })
    render json: { in_wishlist: @wishlist.persisted?, quantity: @wishlists.size }
  end

  def cart
    # Do not remove this delay @brg
    sleep 1

    @order_item = current_user.cart.items
      .where(variant: @variant, size: Size.find(params[:size]))
      .first_or_initialize(quantity: 0)

    @order_item.quantity += 1

    if (@variant.available? || @variant.preorder?) && @order_item.save
      render json: { quantity: current_user.cart.items.map(&:quantity).sum }
    else
      render json: @order_item.errors, status: :unprocessable_entity
    end
  end

  def new
    @product = Product.find_or_initialize_by(id: params[:product_id])
    @variant = Variant.new(product: @product)

    authorize @variant

    respond_to :html, :json
  end

  def create
    @variant = Variant.new(variant_params)

    authorize @variant

    if @variant.save
      head :created, location: catalog_variant_path(slug: @variant.product.category.slug, id: @variant.id)
    else
      render json: @variant.errors, status: :unprocessable_entity
    end
  end

  def edit
    respond_to do |format|
      format.html do
        @colors = Color.all
        @stores = Store.all
        @sizes = Size.where(sizes_group_id: 1)
        @categories = Category.order(weight: :asc).all
      end
      format.json
    end
  end

  def update
    if @variant.update(variant_params)
      head :ok, location: catalog_variant_path(slug: @variant.product.category.slug, id: @variant.id)
    else
      render json: @variant.errors, status: :unprocessable_entity
    end
  end

  def images
    authorize @variant

    render json: { images: @variant.images.sort_by{ |i| [(i.weight.to_i.zero? ? 99 : i.weight), i.created_at] }, wishlist: @variant.in_wishlist(current_user), out_of_stock: @variant.out_of_stock, variant_state: @variant.state }
  end

  private

  def set_variant
    @variant = Variant.find(params[:id])
  end

  def authorize_variant
    authorize @variant || Variant
  end

  # TODO: remove trailing \
  def variant_params
    permitted =
      Variant.globalize_attribute_names \
      + %i[state code color_id price price_last created_at preorder] \
      + [theme_ids: []] \
      + [
        {
          product_attributes: Product.globalize_attribute_names \
            + %i[id category_id]
        }
      ] \
      + [
        images_attributes: %i[id weight favourite]
      ]

    params.require(:variant).permit(*permitted)
  end
end
