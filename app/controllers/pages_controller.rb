class PagesController < ApplicationController
  before_action :authorize_pages

  def index
    @slides = Slide.with_translations(I18n.available_locales)
      .where.not(image: nil).order(weight: :asc)
  end

  def robots
    respond_to :text
    expires_in 6.hours, public: true
  end

  # def contacts; end

  private

  def authorize_pages
    authorize :pages
  end
end
