class KitsController < ApplicationController
  before_action :set_kit, only: [:show, :edit, :update, :destroy]

  layout 'app'

  def index
    authorize Kit
    @kits = Kit.includes(:images, :variants).order(created_at: :desc)

    respond_to do |format|
      format.html
      format.json
    end
  end

  def show
    authorize @kit

    render 'static/gone', status: :not_found, locals: { title: @kit.title }
  end

  def new
    @kit = Kit.new(state: :active)

    authorize @kit
  end

  def edit
    authorize @kit

    respond_to do |format|
      format.html
      format.json
    end
  end

  def create
    @kit = Kit.new(kit_params)
    authorize @kit

    if @kit.save
      head :ok, location: kits_path()
    else
      render :new
    end
  end

  def update
    authorize @kit

    @kit.kitables.destroy_all

    if @kit.update(kit_params)
      head :ok, location: kits_path()
    else
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
    params.require(:kit).permit(:title, :created_at, :theme_id, :state, :latest, image_ids: [], variant_ids: [], images_attributes: [:weight, :id])
  end
end
