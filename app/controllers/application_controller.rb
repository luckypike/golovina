class ApplicationController < ActionController::Base
  include Pundit

  before_action :set_current
  before_action :set_header

  around_action :switch_locale

  after_action :verify_authorized

  protect_from_forgery unless: -> { request.format.json? }

  rescue_from Pundit::NotAuthorizedError, with: :not_authenticated

  private

  def set_current
    Current.user = current_user
  end

  def set_header
    @collections_nav = Collection.nav
    @categories_nav = Category.nav
    @last_nav = Variant.unscoped.active.where(last: true).any?
  end

  def not_authenticated
    if user_signed_in? && current_user.common?
      render :not_authenticated
    else
      session[:return_to_url] = request.original_fullpath
      redirect_to new_user_session_path
    end
  end

  def set_guest_user
    return if user_signed_in?

    user = User.create(email: User.guest_email)
    sign_in(user)
  end

  def switch_locale(&action)
    locale = extract_locale_from_subdomain || I18n.default_locale

    I18n.with_locale(locale, &action)
  end

  def extract_locale_from_subdomain
    parsed_locale = request.subdomains.first
    parsed_locale if I18n.available_locales.map(&:to_s).include?(parsed_locale)
  end
end
