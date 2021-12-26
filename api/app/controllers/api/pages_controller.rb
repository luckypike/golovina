# frozen_string_literal: true

module Api
  class PagesController < Api::ApplicationController
    def index
      render json: current_user
    end
  end
end
