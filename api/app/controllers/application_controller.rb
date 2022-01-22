class ApplicationController < ActionController::Base
  include Pundit

  before_action :set_current
  before_action :set_header
  before_action :store_user_location!, if: :storable_location?

  around_action :switch_locale

  after_action :verify_authorized

  protect_from_forgery unless: -> { request.format.json? }

  rescue_from Pundit::NotAuthorizedError, with: :not_authenticated

  private

  def set_current
    Rails.logger.info('request', request.fullpath)
    Rails.logger.info('request', request.original_url)
    Rails.logger.info('request', request.headers['Cookie'])

    # session['init'] = true
    Current.user = current_user
  end

  def set_header
    @collections_nav = Collection.nav
    @categories_nav = Category.nav
    @nav = Category.nav + Theme.nav
    @last_nav = Variant.unscoped.active.joins(:themables)
      .where(themables: { theme: Theme.find_by(slug: :last) }).any?
    # @last_nav = Variant.unscoped.active.where(last: true).any?
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

  def storable_location?
    request.get? && is_navigational_format? && !devise_controller? && !request.xhr?
  end

  def store_user_location!
    # Rails.logger.info(session.inspect)
    store_location_for(:user, request.fullpath)
  end

  def append_info_to_payload(payload)
    super
    payload[:current_user] = current_user
    payload[:session] = session.as_json
    payload[:cookies] = cookies.as_json
  end
end
