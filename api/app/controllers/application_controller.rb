# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pundit::Authorization

  before_action :set_current
  before_action :set_header
  before_action :store_user_location!, if: :storable_location?

  around_action :switch_locale

  after_action :verify_authorized

  protect_from_forgery unless: -> { request.format.json? }

  rescue_from Pundit::NotAuthorizedError, with: :not_authenticated
  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  private

  def set_current
    sign_out if current_user && cookies[:_golovina_jwt].blank?

    Current.user = current_user
  end

  def set_header
    @nav = Category.nav + Theme.nav
  end

  def not_authenticated
    if user_signed_in? && current_user.common?
      head :unauthorized
    else
      session[:return_to_url] = request.original_fullpath
      redirect_to new_user_session_path
    end
  end

  def not_found
    head :not_found
  end

  def set_guest_user
    return if user_signed_in?

    user = User.create(email: User.guest_email)
    sign_in(user)
    cookies[:_golovina_jwt] = {
      value: Sessions::SetJwtSessionCmd.call(user: user).token,
      expires: 1.year, httponly: true
    }
  end

  def switch_locale(&action)
    locale = extract_locale_from_subdomain || I18n.default_locale

    I18n.with_locale(locale, &action)
  end

  def extract_locale_from_subdomain
    parsed_locale = request.subdomains.first
    parsed_locale if I18n.available_locales.map(&:to_s).include?(parsed_locale)
  end

  def storable_location?
    request.get? && is_navigational_format? && !devise_controller? && !request.xhr?
  end

  def store_user_location!
    store_location_for(:user, request.fullpath)
  end

  def append_info_to_payload(payload)
    super
    payload[:current_user] = current_user
    payload[:session] = session.as_json
    payload[:cookies] = cookies.as_json
  end
end
