class PasswordReset

  def initialize
  end

  def send_reset_email(email)
    # if email found
      # notice: sent you a reset email
    # else
      # error: can't find a user with that email address
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
