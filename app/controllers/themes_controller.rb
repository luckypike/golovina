class ThemesController < ApplicationController
  before_action :set_theme, only: [:edit, :update, :destroy, :show]

  def colors

  end

  def index
    @themes = Theme.all
  end

  def show
    @products = Variant.includes(:images, product: [:kitables]).themed_by([@theme.id]).where.not(images: { id: nil }) + Kit.includes(:images, :products).where.not(kitables: { id: nil }).where(products: { state: :active }).where.not(images: { id: nil })
    # @products = Product.left_outer_joins(:kitables).active.where(kitables: { id: nil }) + Kit.includes(:products).where.not(kitables: { id: nil }).where(products: { state: :active })
  end

  def new
    @theme = Theme.new
  end

  def edit
  end

  def create
    @theme = Theme.new(theme_params)

    if @theme.save
      redirect_to @theme, notice: 'Theme was successfully created.'
    else
      render :new
    end
  end

  def update
    if @theme.update(theme_params)
      redirect_to @theme, notice: 'Theme was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @theme.destroy
    redirect_to themes_url, notice: 'Theme was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_theme
      @theme = Theme.friendly.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def theme_params
      params.require(:theme).permit(:title, :slug, :desc)
    end
end
