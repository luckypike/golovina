# frozen_string_literal: true

module Api
  class ImagesController < Api::ApplicationController
    # before_action :find_image
    before_action :authorize_image

    def touch
      @cmd = Images::TouchCmd.call(image_params: params)
    end

    def create
      @cmd = Images::CreateCmd.call(image_params: params)
    end

    private

    # def find_image
    #   @image = Image.find(params[:id])
    # end

    def authorize_image
      authorize @image || Image
    end
  end
end
