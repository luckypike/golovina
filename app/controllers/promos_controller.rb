class PromosController < ApplicationController
  before_action :set_promo, only: %i[edit update destroy]
  before_action :authorize_promo, only: %i[edit update destroy]

  layout 'app'

  def index
    @promos = Promo.all.order(:id)

    authorize @promos

    respond_to :html, :json
  end

  def edit
    respond_to :html, :json
  end

  def last
    authorize Promo
    
    @promo = Promo.where(popup: true).last
  end

  def create
    @promo = Promo.new(promo_params)
    authorize @promo

    if @promo.save
      head :ok, location: promos_path
    else
      render :new
    end
  end

  def update
    if @promo.update(promo_params)
      head :ok, location: promos_path
    else
      render :edit
    end
  end

  def destroy
    if @promo.destroy
      head :ok, location: promos_path
    else
      render text: "\"#{image.errors.full_messages.first}\"", status: :unprocessable_entity
    end
  end

  private

  def set_promo
    @promo = Promo.find(params[:id])
  end

  def authorize_promo
    authorize @promo
  end

  def promo_params
    params.require(:promo).permit(:title, :link, :front, :popup)
  end
end
