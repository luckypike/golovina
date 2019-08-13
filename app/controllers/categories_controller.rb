class CategoriesController < ApplicationController
  before_action :set_category, only: [:edit, :update, :destroy]

  layout 'app'

  def index
    authorize Category

    @categories = Category.includes(:variants).order(weight: :asc).all
  end

  def show
    @category = Category.active.friendly.find(params[:slug])
    authorize @category

    @variants = @category.variants.available.visible.includes(:images, :product)

    respond_to :html, :json
  end

  def new
    @category = Category.new(state: :active)
    authorize @category
  end

  def edit
    authorize @category
  end

  def create
    @category = Category.new(category_params)
    authorize @category

    if @category.save
      redirect_to categories_path, notice: 'Category was successfully created.'
    else
      render :new
    end
  end

  def update
    authorize @category

    if @category.update(category_params)
      head :ok, location: categories_path
    else
      render json: @category.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @category.destroy
    redirect_to categories_url, notice: 'Category was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.friendly.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def category_params
      params.require(:category).permit(:title, :slug, :state, :weight, :front, image_ids: [], images_attributes: [:weight, :id])
    end
end
