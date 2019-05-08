class SessionPolicy < Struct.new(:user, :session)
  def new?
    true
  end
end
