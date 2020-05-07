PagesPolicy = Struct.new :user, :pages do
  def index?
    true
  end

  def robots?
    index?
  end

  def contacts?
    index?
  end
end
