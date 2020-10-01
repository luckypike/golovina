class ThemesController < ApplicationController
  before_action :set_theme, only: %i[edit show update destroy]
  before_action :authorize_theme

  def index
    @themes = Theme
      .includes(:variants, :translations)
      .order(weight: :asc).all
  end

  def show
    @variants = policy_scope(Variant.select('variants.*, themables.weight').joins(:themables).where(themables: { theme: @theme }).for_list.order('themables.weight ASC'))

    respond_to :html, :json
  end

  def new
    @theme = Theme.new(state: :active)

    authorize @theme
  end

  def edit
    respond_to :html, :json
  end

  def create
    @theme = Theme.new(theme_params)
    authorize @theme

    if @theme.save
      head :ok, location: dashboard_catalog_path
    else
      render json: @theme.errors, status: :unprocessable_entity
    end
  end

  def update
    if @theme.update(theme_params)
      head :ok, location: dashboard_catalog_path
    else
      render json: @theme.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @theme.destroy
    head :ok, location: dashboard_catalog_path
  end

  private

  def authorize_theme
    authorize @theme || Theme
  end

  def set_theme
    @theme = Theme.friendly.find(params[:id])
  end

  def theme_params
    permitted = Theme.globalize_attribute_names + %i[slug image recency state]
    params.require(:theme).permit(*permitted)
  end
end
