# frozen_string_literal: true

module Api
  class ColorsController < Api::ApplicationController
    before_action :authorize_color

    def index
      cmd = Colors::IndexCmd.call
      render json: Colors::IndexResource.new(cmd.colors).serialize
    end

    private

    def authorize_color
      authorize @color || Color
    end
  end
end
