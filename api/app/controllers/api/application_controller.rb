# frozen_string_literal: true

module Api
  class ApplicationController < ActionController::API
    include Pundit::Authorization
    include ApplicationExceptionHandler

    after_action :verify_authorized
    around_action :switch_locale

    def switch_locale(&action)
      locale = request.headers['X-Locale'] || I18n.default_locale
      I18n.with_locale(locale, &action)
    end
  end
end
