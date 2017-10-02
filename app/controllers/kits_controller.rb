class KitsController < ApplicationController
  before_action :set_kit, only: [:show, :edit, :update, :destroy]

  def index
    authorize Kit
    @kits = Kit.order(created_at: :desc)
  end

  def show
    authorize @kit
    @products = @kit.kitables.order(id: :asc).includes(:product).map(&:product)
  end

  def new
    @kit = Kit.new(state: :active)
    # @kit.images.build

    authorize @kit
  end

  def edit
    # @kit.images.build if @kit.images.size == 0
    authorize @kit
  end

  def create
    @kit = Kit.new(kit_params)
    authorize @kit

    if @kit.save
      redirect_to [:kits], notice: 'Kit was successfully created.'
    else
      render :new
    end
  end

  def update
    authorize @kit

    if @kit.update(kit_params)
      redirect_to [:kits], notice: 'Kit was successfully updated.'
    else
      # @kit.images.build if @kit.images.size == 0
      render :edit
    end
  end

  def destroy
    @kit.destroy
    redirect_to kits_url, notice: 'Kit was successfully destroyed.'
  end

  private
  def set_kit
    @kit = Kit.find(params[:id])
  end

  def kit_params
    params[:kit][:image_ids] = JSON.parse(params[:kit][:image_ids]) if params[:kit][:image_ids].present? && params[:kit][:image_ids].is_a?(String)
    params.require(:kit).permit(:title, :created_at, :theme_id, :state, :latest, image_ids: [], product_ids: [], images_attributes: [:weight, :id])
  end
end
