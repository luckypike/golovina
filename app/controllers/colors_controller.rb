class ColorsController < ApplicationController
  before_action :set_color, only: [:show, :edit, :update, :destroy]

  # GET /colors
  def index
    authorize Color
    @colors = Color.all.order(title: :asc)
  end

  # GET /colors/1
  def show
  end

  # GET /colors/new
  def new
    @color = Color.new
    authorize @color
  end

  # GET /colors/1/edit
  def edit
    authorize @color
  end

  # POST /colors
  def create
    @color = Color.new(color_params)
    authorize @color

    if @color.save
      redirect_to [:colors], notice: 'Color was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /colors/1
  def update
    authorize @color
    if @color.update(color_params)
      redirect_to [:colors], notice: 'Color was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /colors/1
  def destroy
    authorize @color
    @color.destroy
    redirect_to [:colors], notice: 'Color was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_color
      @color = Color.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def color_params
      params.require(:color).permit(:title, :color, :image, :parent_color_id, :remove_image)
    end
end
