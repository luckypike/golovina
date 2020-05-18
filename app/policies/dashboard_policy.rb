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
end
