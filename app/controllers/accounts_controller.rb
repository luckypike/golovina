class AccountsController < ApplicationController
  before_action :authorize_account

  def show
  end

  private

  def authorize_account
    authorize :account
  end
end
