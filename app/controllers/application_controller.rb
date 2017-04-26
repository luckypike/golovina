class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :set_cats

  def set_cats
    @themes = Theme.order(id: :asc).limit(8)
    @categories = Category.includes(:products).order(id: :asc).limit(8)
    @colors = Theme::COLORS
  end
end
