class AboutController < ApplicationController
  def index
    authorize :static, :index?
  end

  def collection
    authorize :static, :index?
  end
end
