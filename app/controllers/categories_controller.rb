class CategoriesController < ApplicationController
  before_action :set_category, only: %i[edit update destroy]
  before_action :authorize_category, only: %i[edit update destroy]

  def index
    authorize Category

    @categories = Category
      .includes(:variants, :translations)
      .order(weight: :asc).all
  end

  def show
    @category = Category.friendly.find(params[:slug])
    authorize @category

    @variants = policy_scope(@category.variants.order(weight: :asc).for_list)

    respond_to :html, :json
  end

  def new
    @category = Category.new(state: :active)

    authorize @category
  end

  def edit
    respond_to :html, :json
  end

  def create
    @category = Category.new(category_params)
    authorize @category

    if @category.save
      head :ok, location: categories_path
    else
      render json: @category.errors, status: :unprocessable_entity
    end
  end

  def update
    if @category.update(category_params)
      head :ok, location: categories_path
    else
      render json: @category.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @category.destroy
    head :ok, location: categories_path
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end

  def authorize_category
    authorize @category
  end

  def category_params
    permitted = Category.globalize_attribute_names + %i[slug state front weight]
    params.require(:category).permit(*permitted)
  end
end
