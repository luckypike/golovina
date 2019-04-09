class StaticController < ApplicationController
  layout 'app', only: [:index]

  def index
    authorize :static, :index?

    @slides = Slide.all.order('weight')
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
