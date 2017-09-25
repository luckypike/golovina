class CartPolicy < Struct.new(:user, :dashboard)
  def show?
    true
  end

  def destroy?
    show?
  end
end
