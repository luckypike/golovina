class CustomersController < ApplicationController
  def index
    authorize :static, :index?
    redirect_to customers_info_path
  end

  def return
    authorize :static, :index?
  end

  def info
    authorize :static, :index?
  end
end
