class ServiceController < ApplicationController

  layout 'app'

  def index
    authorize :static, :index?
    redirect_to service_delivery_path
  end

  def return
    authorize :static, :index?
    @user = Current.user
  end

  def delivery
    authorize :static, :index?
  end
end
