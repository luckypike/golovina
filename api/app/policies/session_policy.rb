SessionPolicy = Struct.new :user, :session do
  def new?
    create?
  end

  def show?
    true
  end

  def create?
    true
  end

  def recovery?
    true
  end

  def destroy?
    user
  end
end
