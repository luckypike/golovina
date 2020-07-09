DashboardPolicy = Struct.new :user, :dashboard do
  def index?
    user&.editor?
  end

  def catalog?
    index?
  end

  def variants?
    catalog?
  end

  def catalog_update?
    catalog?
  end

  def variants_update?
    variants?
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

  def users?
    index?
  end
end
