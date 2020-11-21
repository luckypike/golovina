class CertPolicy < ApplicationPolicy
  def index?
    true
  end

  def create?
    true
  end

  def pay?
    true
  end
end
