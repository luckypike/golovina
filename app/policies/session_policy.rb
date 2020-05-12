SessionPolicy = Struct.new :user, :session do
  def new?
    create?
  end

  def create?
    true
  end

  def destroy?
    user
  end
end
