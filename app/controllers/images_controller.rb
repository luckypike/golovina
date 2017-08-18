class ImagesController < ApplicationController
  def create
    image = Image.new(image_params)
    authorize image

    if image.save
      head :ok
    else
      render text: "\"#{image.errors.full_messages.first}\"", status: 422
    end
  end

  private
  def image_params
    params.require(:image).permit(:id, :photo, :imagable_type, :imagable_id)
  end
end
