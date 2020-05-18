class VariantsController < ApplicationController
  before_action :set_guest_user, only: %i[wishlist cart]
  before_action :set_variant, only: %i[edit update wishlist cart]
  # before_action :authorize_variant, only: %i[edit update wishlist cart]
  before_action :authorize_variant, except: :show

  # TODO: REWRITE
  def index
    if params[:kit_id].present?
      @selected = Variant.includes(:product, :images, :color, :kitables).where(id: params[:selected], kitables: { kit_id: params[:kit_id] }).sort_by{ |v| v.kitables.first.id }
    else
      @selected = Variant.includes(:product, :images, :color).where(id: params[:selected])
    end

    if params[:category_id].present?
      @variants = Variant.includes(:product, :images, color: :translations).where.not(id: @selected.map(&:id)).where(products: {category_id: params[:category_id]}).unscope(:order).order(:state, created_at: :desc)
    else
      @variants = Variant.includes(:product, :images, :color).where.not(id: @selected.map(&:id)).unscope(:order).order(:state, created_at: :desc).limit(params[:q].present? ? nil : 12)
    end

    respond_to do |format|
      format.html
      format.json
    end
  end

  # END TODO

  def show
    @category = Category.friendly.find(params[:slug])
    @variant = @category.variants.find_by!(id: params[:id])

    authorize @variant

    @variants = policy_scope(@variant.variants.for_variant)
    #   .with_translations(I18n.available_locales)
    #   .includes(:color, availabilities: %i[size store])

    respond_to :html, :json
  end

  # TODO: create new model Section instead
  def latest
    @variants = policy_scope(Variant.for_list).where(latest: true)

    respond_to :html, :json
  end

  def sale
    @variants = policy_scope(Variant.for_list).where(sale: true)

    respond_to :html, :json
  end

  def last
    @variants = policy_scope(Variant.for_list).where(last: true)

    respond_to :html, :json
  end

  def premium
    @variants = policy_scope(Variant.for_list).where(premium: true)

    respond_to :html, :json
  end

  def stayhome
    @variants = policy_scope(Variant.for_list).where(stayhome: true)

    respond_to :html, :json
  end

  def morning
    @variants = policy_scope(Variant.for_list).where(morning: true)

    respond_to :html, :json
  end

  def all
    @variants = policy_scope(Variant.for_list)

    respond_to :html, :json
  end
  # END TODO

  # TODO: Check below

  # def soon
  #   @variants = policy_scope(Variant.not_archived)
  #     .with_translations(I18n.available_locales)
  #     .includes(product: :variants).available
  #
  #   respond_to :html, :json
  # end

  def list
    authorize Variant

    @variants = Variant.includes(:product, :color).not_archived
    @variants = @variants.select{ |s| s.product.title.downcase.include? params[:q].downcase } if params[:q]

    respond_to :json
  end

  def wishlist
    @wishlist = Wishlist.find_or_initialize_by(user: current_user, variant: @variant)
    @wishlist.persisted? ? @wishlist.destroy : @wishlist.save

    render json: { in_wishlist: @wishlist.persisted?, quantity: current_user.wishlists.size }
  end

  def cart
    # Do not remove this delay @brg
    sleep 1

    @order_item = current_user.cart.items
      .where(variant: @variant, size: Size.find(params[:size]))
      .first_or_initialize(quantity: 0)

    @order_item.quantity += 1

    if @variant.available? && @order_item.save
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
      + %i[state code color_id price price_last created_at latest bestseller sale last pinned premium stayhome morning] \
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
