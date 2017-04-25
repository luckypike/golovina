class StaticController < ApplicationController
  def index
    @themes = Theme.order(id: :asc)
    @categories = Category.includes(:products).order(id: :asc).limit(8)
  end
end
