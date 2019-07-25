class StaticController < ApplicationController
  layout 'app', only: [:index, :contacts]

  def index
    authorize :static, :index?

    @slides = Slide.where.not(image: nil).order('weight').limit(2)
    @categories = Category.where(front: true).order('weight').limit(4)
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
