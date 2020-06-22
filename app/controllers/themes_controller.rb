class ThemesController < ApplicationController
  before_action :set_theme, only: :show
  before_action :authorize_theme

  def show
    @variants = policy_scope(Variant.select('variants.*, themables.weight').joins(:themables).where(themables: { theme: @theme }).for_list.order('themables.weight ASC'))

    respond_to :html, :json
  end

  # def new
  #   @theme = Theme.new
  # end
  #
  # def edit
  #   authorize @theme
  # end
  #
  # def create
  #   @theme = Theme.new(theme_params)
  #
  #   if @theme.save
  #     redirect_to @theme, notice: 'Theme was successfully created.'
  #   else
  #     render :new
  #   end
  # end
  #
  # def update
  #   authorize @theme
  #   if @theme.update(theme_params)
  #     @last_kit = @theme.kits.active.last
  #     if @last_kit.presence
  #       @theme.update_column(:recency, @last_kit[:created_at])
  #     else
  #       @theme.update_column(:recency, @theme[:created_at])
  #     end
  #     redirect_to @theme, notice: 'Theme was successfully updated.'
  #   else
  #     render :edit
  #   end
  # end
  #
  # def destroy
  #   @theme.destroy
  #   redirect_to themes_url, notice: 'Theme was successfully destroyed.'
  # end

  private

  def authorize_theme
    authorize @theme || Theme
  end

  def set_theme
    @theme = Theme.friendly.find(params[:id])
  end

  def theme_params
    params.require(:theme).permit(:title, :title_long, :slug, :desc, :image, :recency)
  end
end
