class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy, :wishlist]

  def index
    where = {}

    %w(theme size).each do |f|
      params[f] = params[f].present? ? params[f].map(&:to_i) : []
      where[f.pluralize] = params[f] if params[f].present? && f != 'theme'
    end

    %w(category color).each do |f|
      params[f] = params[f].present? ? params[f].map(&:to_i) : []
      where[f] = params[f] if params[f].present?
    end

    # params[:category] = params[:category].presence || []
    # params[:color] = params[:color].presence || []
    # params[:theme] = params[:theme].presence || []
    # params[:size] = params[:size].presence || []

    p params
    p where

    @products = Variant.includes(product: [:kind]).themed_by(params[:theme]).where(where).map(&:product).uniq
    # .order(id: :asc)
  end

  def show
  end

  def new
    @product = Product.new()
    if params[:category_id] && category = Category.friendly.find(params[:category_id])
      @product.category = category
    end
  end

  def edit
  end

  def create
    @product = Product.new(product_params)

    if @product.save
      redirect_to @product, notice: 'Product was successfully created.'
    else
      render :new
    end
  end

  def update
    if @product.update(product_params)
      @product.variants.map do |v|
        v.themes = @product.themes.map(&:id)
        v.category = @product.category
      end
      @product.save

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
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def product_params
      params.require(:product).permit(:kind_id, :category_id, :price, :desc, { images: []}, theme_ids: [], variants_attributes: [:id, :_destroy, sizes: []])
    end
end
