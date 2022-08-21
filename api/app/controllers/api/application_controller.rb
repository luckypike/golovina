# frozen_string_literal: true

module Api
  class ApplicationController < ActionController::API
    include Pundit::Authorization
    include ActionController::Cookies
    include ApplicationExceptionHandler

    after_action :verify_authorized
    around_action :switch_locale

    def switch_locale(&action)
      locale = request.headers["X-Locale"] || I18n.default_locale
      I18n.with_locale(locale, &action)
    end

    private

    def current_user
      @current_user ||= Sessions::DecodeJwtCmd.call(jwt: cookies[:_golovina_jwt]).user
    end
  end
end
