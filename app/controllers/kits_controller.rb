class KitsController < ApplicationController
  before_action :set_kit, only: %i[show edit update destroy]
  before_action :authorize_kit, only: %i[show edit update destroy]

  layout 'app'

  def control
    authorize Kit
    @kits = Kit.includes(:images, :variants).order(created_at: :desc)

    respond_to do |format|
      format.html
      format.json
    end
  end

  def index
    authorize Kit

    @kits = Kit.includes(:images, :variants).active

    respond_to :html, :json
  end

  def show
    respond_to :html, :json
  end

  def new
    @kit = Kit.new(state: :active)

    authorize @kit
  end

  def edit
    respond_to :html, :json
  end

  def create
    @kit = Kit.new(kit_params)
    authorize @kit

    if @kit.save
      head :ok, location: control_kits_path
    else
      render :new
    end
  end

  def update
    @kit.kitables.destroy_all

    if @kit.update(kit_params)
      head :ok, location: control_kits_path
    else
      render :edit
    end
  end

  def destroy
    authorize @kit

    if @kit.destroy
      head :ok
    else
      render text: "\"#{image.errors.full_messages.first}\"", status: :unprocessable_entity
    end
  end

  private

  def set_kit
    @kit = Kit.find(params[:id])
  end

  def authorize_kit
    authorize @kit
  end

  def kit_params
    params[:kit][:image_ids] = JSON.parse(params[:kit][:image_ids]) if params[:kit][:image_ids].present? && params[:kit][:image_ids].is_a?(String)
    params.require(:kit).permit(:title, :created_at, :theme_id, :state, :latest, image_ids: [], variant_ids: [], images_attributes: [:weight, :id])
  end
end
