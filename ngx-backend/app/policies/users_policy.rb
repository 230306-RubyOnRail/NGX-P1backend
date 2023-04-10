class UsersPolicy
  def initialize(user)
    @user = user
  end

  def allowed?
    manager?
  end

  def manager?
    @user.where(manager: true)
  end
end