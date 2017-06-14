class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy, :wishlist]

  def index
    @products = Product.order(id: :asc).limit(8)
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
      params.require(:product).permit(:title, :category_id, :price, :desc, { images: []}, variants_attributes: [:id, sizes: []])
    end
end
