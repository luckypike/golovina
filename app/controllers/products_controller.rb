class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy, :wishlist, :cart, :variants, :publish, :info, :similar]

  def index
    authorize Product
    redirect_to [:all, :products]
    #
    # where = {}
    # @products = Variant.includes(:images, product: [:variants]).where(where).order('products.created_at DESC')
    # render :category
  end

  def all
    authorize Product
    @where ||= {}

    %w(category color).each do |f|
      params[f] = params[f].present? ? params[f].map(&:to_i) : []
      @where[f] = params[f] if params[f].present?
    end

    params[:theme] = params[:theme].presence || []
    params[:size] = params[:size].presence || []

    @products = Variant.includes(:images, :product).themed_by(params[:theme]).sized_by(params[:size]).where(@where).where(products: { state: :active }, state: [:active, :out]).order('products.created_at DESC')
    render :all
  end

  def category
    @category = Category.friendly.find(params[:slug])

    @where = {
      category: @category.categories.map(&:id) <<  + @category.id,
      products: { state: :active }
    }

    self.all

    # %w(theme size).each do |f|
    #
    #   where[f.pluralize] = params[f] if params[f].present? && f != 'theme'
    # end

    # %w(category color).each do |f|
    #   params[f] = params[f].present? ? params[f].map(&:to_i) : []
    #   where[f] = params[f] if params[f].present?
    # end




  end

  def control
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

    @products = Variant.includes(:images, :product).where(products: { latest: true, state: :active }, state: [:active, :out])
  end

  def sale
    authorize Product

    @products = Variant.includes(:images, :product).where(products: { sale: true, state: :active }, state: [:active, :out])
  end

  def golovina
    authorize Product

    @products = Variant.includes(:images, :product).where(products: { brand: 1, state: :active }, state: [:active, :out])
  end

  def kits
    authorize Product

    @kits = Kit.includes(:images, variants: [:product, :images]).where.not(kitables: { id: nil }).where(latest: true, state: :active).where.not(images: { id: nil })
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

  def info
    authorize @product

    info = {}
    @product.similar_products.each_with_index do |similar, i|
      @improduct = Product.find(similar.id)
      info[i] = {'id' => similar.id, 'link' => url_for([@improduct, anchor: @improduct.variants.first.id]), 'title' => similar.title, 'price' => similar.price, 'thumb' => similar.photo.thumb.url}
    end

    render json: info
  end

  def similar
    authorize @product

    @variants = @product.variants

    @simproduct = Product.find(params[:simid])

    render 'products/_item', layout: false, locals: {product: @simproduct}
  end

  def destroy
    authorize @product
    @product.destroy
    redirect_to [:control, :products], notice: 'Product was successfully destroyed.'
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
    params.require(:product).permit(:title, :state, :latest, :sale, :brand, :created_at, :kind_id, :category_id, :price, :price_last, :comp, :desc, { images: []}, theme_ids: [], similar_product_ids: [], variants_attributes: [:id, :color_id, :_destroy, sizes: []])
  end
end
