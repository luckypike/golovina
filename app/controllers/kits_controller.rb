class KitsController < ApplicationController
  before_action :set_kit, only: [:show, :edit, :update, :destroy]

  def index
    authorize Kit
    @kits = Kit.all
  end

  def show
    authorize @kit
  end

  def new
    @kit = Kit.new
    @kit.images.build

    authorize @kit
  end

  def edit
    @kit.images.build if @kit.images.size == 0
    authorize @kit
  end

  def create
    @kit = Kit.new(kit_params)
    authorize @kit

    if @kit.save
      redirect_to @kit, notice: 'Kit was successfully created.'
    else
      render :new
    end
  end

  def update
    authorize @kit

    if @kit.update(kit_params)
      redirect_to @kit, notice: 'Kit was successfully updated.'
    else
      @kit.images.build if @kit.images.size == 0
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
    params.require(:kit).permit(:title, :created_at, :theme_id, { images: []}, product_ids: [], images_attributes: [:id, :photo])
  end
end
