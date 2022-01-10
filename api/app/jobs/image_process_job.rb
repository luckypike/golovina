# frozen_string_literal: true

class ImageProcessJob < ApplicationJob
  queue_as :default

  def perform(image:)
    Images::ProcessCmd.call(image: image)
  end
end
