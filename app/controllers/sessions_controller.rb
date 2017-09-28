class SessionsController < ApplicationController
  def login
    authorize :static, :index?

    @user = User.new
  end
end
