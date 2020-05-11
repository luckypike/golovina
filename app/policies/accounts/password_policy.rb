Accounts::PasswordPolicy = Struct.new :user, :password do
  def show?
    update?
  end

  def update?
    true
    # user&.common?
  end
end
