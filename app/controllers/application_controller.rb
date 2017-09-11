class ApplicationController < ActionController::Base
  include Pundit

  protect_from_forgery with: :exception

  before_action :set_cats
  before_action :set_cart

  after_action :verify_authorized, unless: :devise_controller?

  def set_cats
    @themes = Theme.order(weight: :asc)
    @categories = Category.order(id: :asc)
    @colors = Color.order(id: :asc)
  end

  def set_cart
    @cart = Cart.where(user: current_user)
  end

  private
  def set_user
    unless user_signed_in?
      user = User.create(email: "guest_#{Devise.friendly_token.first(10)}@mint-store.ru")
      user.save!(validate: false)
      sign_in(user)
    end
  end
end
