class AboutController < ApplicationController
  def index
    authorize :static, :index?
  end
end
