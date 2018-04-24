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

    @products = Variant.includes(:images, :product).themed_by(params[:theme]).sized_by(params[:size]).where(@where).where(state: [:active]).order('products.created_at DESC')
    render :all
  end

  def category
    @category = Category.friendly.find(params[:slug])

    @where = {
      category: @category.categories.map(&:id) <<  + @category.id,
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
    @variants = Product.includes(variants: [:images, :color]).where(category_id: params[:category_id])
    # params[:archive] ? @variants.where(variants: { state: [:archive]}) : @variants.where(variants: { state: [:active, :out]})
    if params[:archive] == 'true'
      @variants = @variants.where(variants: { state: [:archived]})
    else
      @variants = @variants.where(variants: { state: [:active]})
    end
    @variants = @variants.order(created_at: :desc).map(&:variants).flatten

    # @categories = Category.includes(:products).all
  end

  def show
    authorize @product

    if !@product.purchasable
      if !current_user || !current_user.is_editor?
        render 'static/gone', status: :gone, locals: {title: @product.title}
      end
    end
  end

  def new
    @product = Product.new
    # @product.variants.build
    if params[:category_id] && category = Category.friendly.find(params[:category_id])
      @product.category = category
    end
    authorize @product
  end

  def create
    @product = Product.new(product_params)
    authorize @product

    if @product.save
      redirect_to [:edit, @product], notice: 'Товар был создан, нужно добавить цвета и размеры чтобы он появился в каталоге!'
    else
      render :new
    end
  end

  def edit
    session[:id] =  params[:ref] if params[:ref]
    authorize @product
    @product.variants.build if @product.variants.empty?
  end

  def update
    authorize @product

    if @product.update(product_params)
      if session[:id]
        redirect_to session[:id], notice: 'Product was successfully updated.'
      else
        redirect_to @product, notice: 'Product was successfully updated.'
      end
    else
      render :edit
    end
  end

  def latest
    authorize Product

    @products = Variant.includes(:images, :product).where(products: { latest: true}, state: [:active])
  end

  def sale
    authorize Product

    @products = Variant.includes(:images, :product).where(products: { sale: true}, state: [:active])
  end

  def golovina
    authorize Product

    @products = Variant.includes(:images, :product).where(products: { brand: 1}, state: [:active])
  end

  def kits
    authorize Product

    @kits = Kit.includes(:images, variants: [:product, :images]).where.not(kitables: { id: nil }).where(latest: true, state: :active).where.not(images: { id: nil })
  end

  def variants
    authorize Product
    @variant = Variant.new(product: @product)
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

    if !@product.in_order?
      @product.destroy
      redirect_to control_products_path()
    else
      redirect_to [:edit, @product], notice: 'Товар нельзя удалить, так как он присутствует в сформированных заказках.'
    end
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
    size_keys = []
    if params[:product][:variants_attributes].present?
      params[:product][:variants_attributes].each do |_, va|
        if va[:sizes].present?
          size_keys = va.try(:fetch, :sizes, {}).keys
        end
        if va[:image_ids].present? && va[:image_ids].is_a?(String)
          va[:image_ids] = JSON.parse(va[:image_ids])
        end
      end
    end
    params.require(:product).permit(:title, :category_id, :latest, :sale, :brand, :pinned, :price, :price_last, :comp, :desc, similar_product_ids: [], variants_attributes: [:id, :color_id, :_destroy, :state, :out_of_stock, image_ids: [], sizes: size_keys, images_attributes: [:id, :weight]])
  end
end
