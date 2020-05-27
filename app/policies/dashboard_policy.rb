DashboardPolicy = Struct.new :user, :dashboard do
  def index?
    user&.editor?
  end

  def cart?
    index?
  end

  def archived?
    index?
  end

  def refunds?
    index?
  end

  def wishlists?
    index?
  end
end
