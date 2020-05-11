class Accounts::UserPolicy < ApplicationPolicy
  def show?
    update?
  end

  def password?
    update?
  end

  def update?
    user&.common? && user == record
  end
end
