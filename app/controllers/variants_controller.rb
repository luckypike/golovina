class VariantsController < ApplicationController
  before_action :set_user, only: %i[wishlist cart]
  before_action :set_variant, only: %i[edit update wishlist cart notification]
  before_action :authorize_variant, only: %i[edit update wishlist cart]

  skip_after_action :verify_authorized, only: %i[latest soon sale last all]

  layout 'app'

  # TODO: REWRITE
  def index
    authorize Variant

    if params[:kit_id].present?
      @selected = Variant.includes(:product, :images, :color, :kitables).where(id: params[:selected], kitables: { kit_id: params[:kit_id] }).sort_by{ |v| v.kitables.first.id }
    else
      @selected = Variant.includes(:product, :images, :color).where(id: params[:selected])
    end

    if params[:category_id].present?
      @variants = Variant.includes(:product, :images, :color).where.not(id: @selected.map(&:id)).where(products: {category_id: params[:category_id]}).order(created_at: :desc)
    else
      @variants = Variant.includes(:product, :images, :color).where.not(id: @selected.map(&:id)).order(created_at: :desc).limit(params[:q].present? ? nil : 12)
    end

    respond_to do |format|
      format.html
      format.json
    end
  end

  # END TODO

  def latest
    @variants = policy_scope(Variant.not_archived)
      .includes(product: :variants).where(latest: true)

    respond_to :html, :json
  end

  def soon
    @variants = policy_scope(Variant.not_archived)
      .includes(product: :variants).available

    respond_to :html, :json
  end

  def sale
    @variants = policy_scope(Variant.not_archived)
      .includes(product: :variants).where(sale: true)

    respond_to :html, :json
  end

  def last
    @variants = policy_scope(Variant.not_archived)
      .includes(product: :variants).where(last: true)

    respond_to :html, :json
  end

  def all
    @variants = policy_scope(Variant.not_archived)
      .includes(product: :variants)

    respond_to :html, :json
  end

  def list
    authorize Variant

    @variants = Variant.includes(:product, :color).available
    @variants = @variants.select{ |s| s.product.title.downcase.include? params[:q].downcase } if params[:q]

    respond_to :json
  end

  def wishlist
    @wishlist = Wishlist.find_or_initialize_by(user: current_user, variant: @variant)
    @wishlist.persisted? ? @wishlist.destroy : @wishlist.save

    render json: { in_wishlist: @wishlist.persisted? }
  end

  def notification
    authorize @variant

    user = User.find_by(email: params[:variant][:email])

    if signed_in?
      @notification = Notification.find_or_initialize_by(user: current_user, variant: @variant)
      if current_user.guest? && !user
        current_user.activate(params[:variant][:email])
      elsif current_user.guest? && user
        @notification = Notification.find_or_initialize_by(user: user, variant: @variant)
      end
    else
      user = User.where(email: params[:variant][:email]).first_or_initialize
      if user.new_record?
        user.activate(params[:variant][:email])
        sign_in(user)
      end
      @notification = Notification.find_or_initialize_by(user: user, variant: @variant)
    end
    @notification.save

    render json: { in_notification: @notification.persisted? }
  end

  def cart
    sleep 1

    if @variant.sizes.find_by_id!(params[:size]) && @variant.active?
      @cart = Cart.find_or_initialize_by(user: current_user, variant: @variant, size: Size.find(params[:size]))
      @cart.quantity += 1 if @cart.persisted?
      @cart.save
    end

    render json: { quantity: Cart.where(user: Current.user).map(&:quantity).sum }
  end

  def show
    @category = Category.friendly.find(params[:slug])
    @variant = @category.variants.find_by!(id: params[:id])

    authorize @variant

    @variants = policy_scope(@variant.product.variants).includes(:translations, :color, availabilities: [:size, :store])

    respond_to :html, :json
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

  def authorize_variant
    authorize @variant
  end

  def set_variant
    @variant = Variant.find(params[:id])
  end

  # TODO: remove trailing \
  def variant_params
    permitted =
      Variant.globalize_attribute_names \
      + %i[state code color_id price price_last created_at] \
      + [
        {
          availabilities_attributes: %i[id size_id store_id quantity _destroy],
          product_attributes: Product.globalize_attribute_names \
            + %i[id category_id]
        }
      ] \
      + [
        images_attributes: %i[id weight favourite]
      ]

    params.require(:variant).permit(*permitted)

    # params.require(:variant).permit(:color_id, :code, :out_of_stock, :state, :created_at, :latest, :sale, :last, :soon, :pinned, :desc, :comp, :price, :price_last, :show, :product_id, product_attributes: [:id, :title, :category_id ], availabilities_attributes: [:id, :variant_id, :size_id, :store_id, :quantity, :_destroy], image_ids: [], images_attributes: [:id, :weight, :favourite])
  end
end
