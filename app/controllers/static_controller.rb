class StaticController < ApplicationController
  layout 'app', only: [:index, :contacts]

  def index
    authorize :static, :index?

    @slides = Slide.with_translations.where.not(image: nil).order(weight: :asc)
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
