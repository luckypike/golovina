class WishlistPolicy < Struct.new(:user, :dashboard)
  def show?
    true
  end
end
