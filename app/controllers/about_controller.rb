class AboutController < ApplicationController
  def index
    authorize :static, :index?
  end

  def collection
    authorize :static, :index?
  end

  def lookbook
    authorize :static, :index?
  end

  def xmas
    authorize :static, :index?
  end

  def brand
    authorize :static, :index?
  end

  def open
    authorize :static, :index?
  end
end
