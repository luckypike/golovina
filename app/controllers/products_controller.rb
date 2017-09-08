class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy, :wishlist, :cart, :variants, :publish]

  def index
    authorize Product
    @categories = Category.includes(:products).all
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

    @products = Variant.includes(:images, product: [:variants]).where(products: { latest: true })
  end

  def sale
    authorize Product

    @products = Variant.includes(:images, product: [:variants]).where(products: { sale: true })
  end

  def category
    authorize Product
    @category = Category.friendly.find(params[:slug])

    where = {
      category: @category.categories.map(&:id) <<  + @category.id
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
    @variant = Variant.new(product: @product)
  end

  def create
    @product = Product.new(product_params)
    authorize @product

    if @product.save
      redirect_to [:variants, @product], notice: 'Product was successfully created.'
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

  def publish
    authorize @product

    @product.active!

    redirect_to @product
  end

  private
  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:title, :state, :latest, :sale, :created_at, :kind_id, :category_id, :price, :desc, { images: []}, theme_ids: [], variants_attributes: [:id, :color_id, :_destroy, sizes: []])
  end
end
