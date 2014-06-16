class PasswordReset

  PASSWORD_RESET_EMAIL_SENT = %{
    We sent a password reset link to your email address.
  }.squish

  USER_NOT_FOUND = %{
    Sorry! Can't find a user with that your email address.
  }.squish

  PASSWORD_WAS_RESET = %{
    Your password has been reset.
  }.squish

  UNABLE_TO_RESET_PASSWORD = %{
    Unable to reset your password. Please try again.
  }

  def initialize
  end

  def send_reset_email(email)
    out = {}

    if user = User.find_by( email: email )
      user.set_reset
      EmailValidator.send_password_reset_email(user).deliver

      out[:message] = PASSWORD_RESET_EMAIL_SENT
        .sub("your email address", email.downcase)
      out[:type] = :success
    else
      out[:message] = USER_NOT_FOUND
        .sub("your email address", email.downcase)
      out[:type] = :error
    end

    out
  end

  def reset_user_password(user, attrs)
    out = {}

    if user.update_attributes( attrs )
      user.clear_reset
      out[:message] = PASSWORD_WAS_RESET
      out[:type] = :success
    else
      out[:message] = UNABLE_TO_RESET_PASSWORD
      out[:type] = :error
    end

    out
  end
end
