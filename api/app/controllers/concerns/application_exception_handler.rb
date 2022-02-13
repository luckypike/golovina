# frozen_string_literal: true

module ApplicationExceptionHandler
  extend ActiveSupport::Concern

  included do
    rescue_from ServiceActor::Failure do |e|
      render json: { errors: e.result.errors }, status: e.result.http_status_code
    end

    rescue_from Pundit::NotAuthorizedError do |e|
      render json: { errors: e.message }, status: :unauthorized
    end

    rescue_from I18n::InvalidLocale do |e|
      head :bad_request
    end
  end
end
