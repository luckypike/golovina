class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :set_cats

  def set_cats
    @themes = Theme.order(id: :asc)
    @categories = Category.order(id: :asc)
    @colors = Color.order(id: :asc)

    # @kits = Kit.order(id: :asc)
    # @products = Product.order(id: :asc)
  end
end
