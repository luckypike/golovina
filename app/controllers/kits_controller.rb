class KitsController < ApplicationController
  before_action :set_kit, only: [:show, :edit, :update, :destroy]

  # GET /kits
  def index
    @kits = Kit.all
  end

  # GET /kits/1
  def show
  end

  # GET /kits/new
  def new
    @kit = Kit.new
    @kit.images.build
  end

  # GET /kits/1/edit
  def edit
    @kit.images.build if @kit.images.size == 0
  end

  # POST /kits
  def create
    @kit = Kit.new(kit_params)

    if @kit.save
      redirect_to @kit, notice: 'Kit was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /kits/1
  def update
    # images = @kit.images
    # images += kit_params[:images]
    # @kit.images = images
    #
    # params[:kit].delete(:images)

    if @kit.update(kit_params)
      redirect_to @kit, notice: 'Kit was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /kits/1
  def destroy
    @kit.destroy
    redirect_to kits_url, notice: 'Kit was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_kit
      @kit = Kit.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def kit_params
      params.require(:kit).permit(:title, :created_at, :theme_id, { images: []}, product_ids: [], images_attributes: [:photo])
    end
end
