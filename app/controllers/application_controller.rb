class ApplicationController < ActionController::Base
  include Pundit

  rescue_from Pundit::NotAuthorizedError, with: :not_authenticated

  protect_from_forgery with: :exception

  before_action :set_cats
  before_action :set_cart

  after_action :verify_authorized, unless: :devise_controller?

  def set_cats
    @themes = Theme.active.order(recency: :asc, weight: :asc)
    @categories = Category.includes(:parent_category, :categories).active.order(weight: :asc)
    @colors = Color.includes(:parent_color).order(title: :asc)
  end

  def set_cart
    @cart = Cart.where(user: current_user)
  end

  private

  def not_authenticated
    session[:return_to_url] = request.original_fullpath
    redirect_to login_path, alert: t(:login_first)
  end

  def set_user
    unless user_signed_in?
      user = User.create(email: "guest_#{Devise.friendly_token.first(10)}@mint-store.ru")
      user.save!(validate: false)
      sign_in(user)
    end
  end
end
