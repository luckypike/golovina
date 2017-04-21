class StaticController < ApplicationController
  def index
    @themes = Theme.order(id: :asc)
  end
end
