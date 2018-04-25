class CartPolicy < Struct.new(:user, :dashboard)
  def show?
    true
  end

  def discount?
    show?
  end

  def destroy?
    show?
  end
end
