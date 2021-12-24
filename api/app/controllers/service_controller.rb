class ServiceController < ApplicationController
  before_action :authorize_page

  def index
    redirect_to service_delivery_path
  end

  def return
    @user = Current.user
  end

  private

  def authorize_page
    authorize :page, :index?
  end
end
