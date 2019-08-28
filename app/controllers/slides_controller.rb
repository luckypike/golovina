class SlidesController < ApplicationController
  before_action :set_slide, only: %i[edit update destroy]
  # before_action :set_slide, only: [:show, :edit, :update, :destroy]

  layout 'app'

  def index
    authorize Slide

    @slides = Slide.order(weight: :asc, id: :asc)
  end

  def new
    @slide = Slide.new

    authorize @slide
  end

  def create
    @slide = Slide.new(slide_params)

    authorize @slide

    if @slide.save
      head :ok, location: slides_path
    else
      render json: @slide.errors, status: :unprocessable_entity
    end
  end

  def edit
    authorize @slide
  end

  def update
    authorize @slide

    if @slide.update(slide_params)
      head :ok, location: slides_path
    else
      render json: @slide.errors, status: :unprocessable_entity
    end
  end

  # DELETE /slides/1
  def destroy
    authorize @slide

    @slide.destroy
    head :ok, location: slides_path
  end

  private

  def set_slide
    @slide = Slide.find(params[:id])
  end

  def slide_params
    permitted = Slide.globalize_attribute_names + %i[weight link image]
    params.require(:slide).permit(*permitted)
  end
end
