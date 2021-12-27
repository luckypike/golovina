# frozen_string_literal: true

module Api
  class SessionsController < Api::ApplicationController
    def show
      authorize :session
    end
  end
end
