# frozen_string_literal: true

module ApplicationExceptionHandler
  extend ActiveSupport::Concern

  included do
    rescue_from ServiceActor::Failure do |e|
      render json: { errors: e.result.errors }, status: e.result.http_status_code
    end
  end
end
