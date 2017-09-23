class CustomersController < ApplicationController
  def index
    authorize :static, :index?
    redirect_to customers_delivery_path
  end

  def delivery
    authorize :static, :index?
  end

  def payment
    authorize :static, :index?
  end

  def return
    authorize :static, :index?
  end
end
