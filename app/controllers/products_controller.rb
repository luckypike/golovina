class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy, :wishlist]

  def demo
    @kits = Kit.order(id: :asc).limit(3)
    @products = Product.order(id: :asc).limit(8)
  end

  # GET /products
  def index
    @products = Product.all
  end

  # GET /products/1
  def show
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products
  def create
    @product = Product.new(product_params)

    if @product.save
      redirect_to @product, notice: 'Product was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /products/1
  def update
    p product_params
    if @product.update(product_params)
      redirect_to [@product.category, @product, :variants], notice: 'Product was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /products/1
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
    p current_user

    wishlist = Wishlist.find_or_initialize_by(user: current_user, product: @product)
    wishlist.persisted? ? wishlist.destroy : wishlist.save

    p wishlist

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
