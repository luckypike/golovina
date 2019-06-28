class VariantsController < ApplicationController
  before_action :set_user, only: [:wishlist, :cart]
  before_action :set_variant, only: [:wishlist, :cart, :notification, :edit, :update, :destroy, :images]
  before_action :authorize_variant, only: [:wishlist, :cart, :edit, :update]

  layout 'app'

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

  def list
    authorize Variant

    @variants = Variant.includes(:product, :color).available
    @variants = @variants.select{ |s| s.product.title.downcase.include? params[:q].downcase } if params[:q]
    respond_to do |format|
      format.json
    end
  end

  def wishlist
    @wishlist = Wishlist.find_or_initialize_by(user: current_user, variant: @variant)
    @wishlist.persisted? ? @wishlist.destroy : @wishlist.save

    render json: { in_wishlist: @wishlist.persisted? }
  end

  def notification
    authorize @variant

    if signed_in?
      @notification = Notification.find_or_initialize_by(user: current_user, variant: @variant)
    else
      @user = User.where(email: params[:variant][:email]).first_or_initialize
      if @user.new_record?
        @password = Devise.friendly_token.first(8)
        @user.update_attributes({ password: @password, password_confirmation: @password, state: 1 })
        @user.save!(validate: false)
        sign_in(@user)
        RegisterMailer.register_mailer(@password, @user).deliver_now
      end
      @notification = Notification.find_or_initialize_by(user: @user, variant: @variant)
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

    render json: @cart.slice(:id, :quantity)
  end

  def show
    @category = Category.friendly.find(params[:slug])
    @variant = @category.variants.find_by_id!(params[:id])

    authorize @variant

    respond_to do |format|
      format.html

      format.json do
        @variant = @category.variants.find_by_id(params[:id])
      end
    end
  end

  def all
    authorize Variant

    respond_to do |format|
      format.html
      format.json do
        # @where ||= {}
        #
        # %w(category color).each do |f|
        #   params[f] = params[f].present? ? params[f].map(&:to_i) : []
        #   @where[f] = params[f] if params[f].present?
        # end
        #
        # params[:theme] = params[:theme].presence || []
        # params[:size] = params[:size].presence || []

        @variants = Variant.available
      end
    end
  end

  def latest
    authorize Variant

    respond_to do |format|
      format.html
      format.json do
        @variants = Variant.available.where(latest: true)
      end
    end
  end

  def sale
    authorize Variant

    respond_to do |format|
      format.html
      format.json do
        @variants = Variant.available.where(sale: true)
      end
    end
  end

  def soon
    authorize Variant

    respond_to do |format|
      format.html
      format.json do
        @variants = Variant.soon
      end
    end
  end

  def new
    @variant = Variant.new
    authorize @variant

    @colors = Color.all
    @stores = Store.all
    @sizes = Size.where(sizes_group_id: 1)
    @categories = Category.order(weight: :asc).all

    @product = params[:product_id].present? ? Product.select(:id, :category_id, :title).find(params[:product_id]) : nil
  end

  def create
    @variant = Variant.new(variant_params)

    authorize @variant

    if @variant.save!
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

  def destroy
    authorize @variant

    @variant.destroy

    redirect_to [:variants, @variant.product]
  end

  private
  def authorize_variant
    authorize @variant
  end

  def set_variant
    @variant = Variant.find(params[:id])
  end

  def variant_params
    params.require(:variant).permit(:color_id, :code, :out_of_stock, :state, :created_at, :latest, :sale, :soon, :pinned, :desc, :comp, :price, :price_last, :product_id, product_attributes: [:id, :title, :category_id ], availabilities_attributes: [:id, :variant_id, :size_id, :store_id, :quantity, :_destroy], image_ids: [], images_attributes: [:id, :weight])
  end
end
