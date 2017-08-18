class StaticController < ApplicationController
  def index
    authorize :static, :index?
  end

  def contacts
    authorize :static, :index?
  end
end
