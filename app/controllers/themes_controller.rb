class ThemesController < ApplicationController
  before_action :set_theme, only: [:edit, :update, :destroy, :show]

  def latest
    authorize Theme

    @kits = Kit.active.latest.includes(:images, { variants: [:images, :product] }).where.not(kitables: { id: nil }).where.not(images: { id: nil })
  end

  def index
    authorize Theme

    @themes = Theme.all.includes(kits: [{ variants: [:product, :images] }, :images]).where(kits: { state: :active })
    # redirect_to Theme.order(weight: :asc).first
  end

  def show
    authorize @theme

    @kits = Kit.active.latest.includes(:images, { variants: [:images, :product] }).where(theme: @theme).where.not(kitables: { id: nil }).where.not(images: { id: nil })

    # @kits = Kit.includes(:images, :variants).where.not(kitables: { id: nil }).where(variants: { state: [:active] }, theme: @theme, state: :active).where.not(images: { id: nil })
    # excluded_products = kits.map(&:variants).flatten.map(&:id)

    # variants = Variant.includes(:images, :kitables, :product).themed_by([@theme.id]).where(state: [:active, :out], products: { state: :active }).where.not(images: { id: nil }, id: excluded_products)
    # @products = kits + variants
  end

  def new
    @theme = Theme.new
  end

  def edit
    authorize @theme
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
    authorize @theme
    if @theme.update(theme_params)
      @last_kit = @theme.kits.active.last
      if @last_kit.presence
        @theme.update_column(:recency, @last_kit[:created_at])
      else
        @theme.update_column(:recency, @theme[:created_at])
      end
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
      params.require(:theme).permit(:title, :title_long, :slug, :desc, :image, :recency)
    end
end
