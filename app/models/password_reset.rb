class PasswordReset

  def initialize
  end

  def send_reset_email(email)
    out = {}

    if user = User.find_by( email: email )
      user.set_reset
      EmailValidator.send_password_reset_email(user).deliver

      out[:message] = "We sent a password reset link to #{email}."
      out[:type] = :success
    else
      out[:message] = "Sorry! Can't find a user with that email address."
      out[:type] = :error
    end

    out
  end

  def reset_user_password(attrs)
    # use password and password confirmation to reset the password
    # if successful
      # notice: your password has been reset
      # log user in
    # else
      # error: password reset failed. please try again.
  end
end
