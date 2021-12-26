# frozen_string_literal: true

module Api
  class SessionsController < Api::ApplicationController
    def show
      render json: current_user
    end
  end
end
