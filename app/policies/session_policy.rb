class SessionPolicy < Struct.new(:user, :session)
  def new?
    true
  end

  def create?
    true
  end

  def phone?
    true
  end

  def code?
    true
  end

  def recovery?
    true
  end

  def auth?
    true
  end

  def destroy?
    user
  end
end
