class SlidesController < ApplicationController
  before_action :set_slide, only: %i[edit update destroy]

  def index
    authorize Slide

    @slides = Slide.order(weight: :asc, id: :asc)
  end

  def new
    @slide = Slide.new

    authorize @slide
  end

  def create
    params[:slide][:video_mp4] = nil if slide_params[:video_mp4] == 'null'
    params[:slide][:video] = nil if slide_params[:video] == 'null'

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

    params[:slide][:video_mp4] = nil if slide_params[:video_mp4] == 'null'
    params[:slide][:video] = nil if slide_params[:video] == 'null'

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
    permitted =
      Slide.globalize_attribute_names \
       + %i[weight link image] \
       + %i[video video_mp4]

    params.require(:slide).permit(*permitted)
  end
end
