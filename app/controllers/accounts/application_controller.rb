class Accounts::ApplicationController < ApplicationController
  before_action :set_user

  def authorize(record, query = nil)
    super([:accounts, record], query)
  end

  def policy_scope(scope)
    super([:accounts, scope])
  end

  private

  def set_user
    @user = current_user
  end
end
