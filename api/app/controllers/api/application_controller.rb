
# frozen_string_literal: true

module Api
  class ApplicationController < ActionController::API
    include Pundit
    include ApplicationExceptionHandler

    after_action :verify_authorized

    private

    def authorize(record, query = nil)
      super([:api, record], query)
    end
  end
end
