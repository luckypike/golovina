class StaticController < ApplicationController
  def index
    authorize :static, :index?

    @slides = Slide.with_translations(I18n.available_locales)
      .where.not(image: nil).order(weight: :asc)
  end

  def contacts
    authorize :static, :index?
  end

  def robots
    authorize :static, :robots?
    respond_to :text
    expires_in 6.hours, public: true
  end
end
