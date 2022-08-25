# frozen_string_literal: true

module Api
  class ColorsController < Api::ApplicationController
    before_action :authorize_color

    def index
      cmd = Colors::IndexCmd.call
      render json: Colors::IndexResource.new(cmd.colors).serialize
    end

    def show
      cmd = Colors::ShowCmd.call(color_id: params[:id])
      render json: Colors::ShowResource.new(cmd.color).serialize
    end

    def create
      cmd = Colors::CreateCmd.call(color_params: params)
      render json: Colors::CreateAndUpdateResource.new(cmd.color).serialize
    end

    def update
      cmd = Colors::UpdateCmd.call(color_id: params[:id], color_params: params)
      render json: Colors::CreateAndUpdateResource.new(cmd.color).serialize
    end

    private

    def authorize_color
      authorize Color
    end
  end
end
