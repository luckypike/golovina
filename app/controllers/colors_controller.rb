class ColorsController < ApplicationController
  before_action :set_color, only: %i[edit update destroy]

  layout 'app'

  def index
    authorize Color

    @colors = Color.main.with_translations.includes(colors: :translations).includes(:variants).order(id: :asc)
  end

  def show
  end

  def new
    @color = Color.new
    authorize @color
  end

  def edit
    authorize @color
  end

  def create
    @color = Color.new(color_params)
    authorize @color

    if @color.save
      head :ok, location: colors_path
    else
      render json: @color.errors, status: :unprocessable_entity
    end
  end

  def update
    authorize @color
    if @color.update(color_params)
      head :ok, location: colors_path
    else
      render json: @color.errors, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @color

    @color.destroy
    head :ok, location: colors_path
  end

  private

  def set_color
    @color = Color.find(params[:id])
  end

  def color_params
    permitted = Color.globalize_attribute_names + %i[color image parent_color_id remove_image]
    params.require(:color).permit(*permitted)
  end
end
