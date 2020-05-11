AccountPolicy = Struct.new :user, :account do
  def show?
    user&.common?
  end
end
