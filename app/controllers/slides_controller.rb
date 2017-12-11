class SlidesController < ApplicationController
  before_action :set_slide, only: [:show, :edit, :update, :destroy]

  def index
    @slides = Slide.all.order('weight')

    authorize @slides
  end

  def new
    @slide = Slide.new

    authorize @slide
  end

  # GET /slides/1/edit
  def edit
    authorize @slide
  end

  # POST /slides
  def create
    @slide = Slide.new(slide_params)

    authorize @slide

    if @slide.save
      redirect_to slides_path, notice: 'Slide was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /slides/1
  def update
    authorize @slide

    if @slide.update(slide_params)
      redirect_to slides_path, notice: 'Slide was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /slides/1
  def destroy
    authorize @slide

    @slide.destroy
    redirect_to slides_url, notice: 'Slide was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_slide
      @slide = Slide.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def slide_params
      params.require(:slide).permit(:name, :link, :link_name, :logo, :image, :left_offset, :top_offset, :weight)
    end
end
