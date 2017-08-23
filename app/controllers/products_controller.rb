class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy, :wishlist, :variants]

  def index
    authorize Product
    @products = Product.order(id: :desc)
  end

  def show
    authorize @product
  end

  def new
    @product = Product.new()
    @product.variants.build
    if params[:category_id] && category = Category.friendly.find(params[:category_id])
      @product.category = category
    end
    authorize @product
  end

  def edit
    authorize @product
  end

  def latest
    authorize Product

    @products = Variant.includes(:product).where(products: { latest: true }).map(&:product).uniq
  end

  def sale
    authorize Product

    @products = Variant.includes(:product).where(products: { sale: true }).map(&:product).uniq
  end

  def category
    authorize Product
    @category = Category.friendly.find(params[:slug])

    where = {
      category: @category.categories
    }

    # %w(theme size).each do |f|
    #   params[f] = params[f].present? ? params[f].map(&:to_i) : []
    #   where[f.pluralize] = params[f] if params[f].present? && f != 'theme'
    # end

    # %w(category color).each do |f|
    #   params[f] = params[f].present? ? params[f].map(&:to_i) : []
    #   where[f] = params[f] if params[f].present?
    # end

    # # params[:category] = params[:category].presence || []
    # # params[:color] = params[:color].presence || []
    # # params[:theme] = params[:theme].presence || []
    # # params[:size] = params[:size].presence || []

    @products = Variant.includes(:images, product: [:variants]).themed_by(params[:theme]).where(where)
    # # .order(id: :asc)
  end

  def variants
    authorize Product
  end

  def create
    @product = Product.new(product_params)
    authorize @product

    if @product.save
      redirect_to @product, notice: 'Product was successfully created.'
    else
      render :new
    end
  end

  def update
    authorize @product

    if @product.update(product_params)
      redirect_to @product, notice: 'Product was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @product.destroy
    redirect_to products_url, notice: 'Product was successfully destroyed.'
  end

  def wishlist
    unless user_signed_in?
      user = User.create(email: "guest_#{Time.now.to_i}#{rand(100)}@mint-store.ru")
      user.save!(validate: false)
      sign_in(user)
    end

    wishlist = Wishlist.find_or_initialize_by(user: current_user, product: @product)
    wishlist.persisted? ? wishlist.destroy : wishlist.save

    redirect_to [@product.category, @product]
  end


  private
  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:title, :state, :latest, :sale, :created_at, :kind_id, :category_id, :price, :desc, { images: []}, theme_ids: [], variants_attributes: [:id, :color_id, :_destroy, sizes: []])
  end
end
