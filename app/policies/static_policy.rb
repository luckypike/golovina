class StaticPolicy < Struct.new(:user, :dashboard)
  def index?
    true
  end

  def robots?
    true
  end
end
