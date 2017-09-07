class ApplicationController < ActionController::Base
  include Pundit

  protect_from_forgery with: :exception

  before_action :set_cats
  after_action :verify_authorized, unless: :devise_controller?

  def set_cats
    @themes = Theme.order(weight: :asc)
    @categories = Category.order(id: :asc)
    @colors = Color.order(id: :asc)
  end
end
