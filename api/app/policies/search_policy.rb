SearchPolicy = Struct.new :user, :search do
  def index?
    true
  end
end
