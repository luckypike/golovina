# frozen_string_literal: true

module Api
  class PagesController < Api::ApplicationController
    before_action :authorize_page

    def index
      @slides = Slide.with_translations(I18n.available_locales).includes(:video_mp4_attachment)
        .where.not(image: nil).order(weight: :asc)

      # @instagram = Rails.cache.read("instagram") || []
      @instagram = []
    end

    private

    def authorize_page
      authorize %i[api page]
    end
  end
end
