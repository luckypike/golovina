class StaticController < ApplicationController
  def index
    @themes = Theme.order(id: :asc)
    @kits = Kit.order(id: :desc).limit(7)
  end
end
