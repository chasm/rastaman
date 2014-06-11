class UserLogin

  def initialize
  end

  def log_user_in(email, password)
    out = { user: User.authenticate(email, password) }

    unless out[:user]
      out[:message] = "Unable to log you in. Please try again."
      out[:type] = :error
    end

    out
  end
end
