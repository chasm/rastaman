class UserRegistration

  ALREADY_REGISTERED = %{
    You are already registered. We sent you a password
    reset email instead.
  }.squish

  REGISTRATION_EMAIL_SENT = %{
    We sent you an email to allow you to
    complete your registration.
  }.squish

  REGISTRATION_EMAIL_FAILED = %{
    Unable to register you. Please check your email address.
  }.squish

  REGISTRATION_COMPLETED = %{
    Thank you for completing your registration. Welcome!
  }.squish

  REGISTRATION_FAILED = %{
    Unable to complete your registration. Please check your form.
  }.squish

  def initialize()
  end

  def send_registration_email(email)
    out = {}

    if user = User.find_by(email: email)
      out = PasswordReset.new.send_reset_email(email)
      out[:message] = ALREADY_REGISTERED if out[:type] == :success
    else
      registrant = Registrant.new( email: email )

      if registrant.save
        EmailValidator.send_registration_email(registrant).deliver

        out[:message] = REGISTRATION_EMAIL_SENT
        out[:type] = :success
      else
        out[:message] = REGISTRATION_EMAIL_FAILED
        out[:type] = :error
      end
    end

    out
  end

  def complete_user_registration(registrant, attrs)
    out = {
      user: User.new( attrs.merge(email: registrant.email) )
    }

    if out[:user].save
      registrant.destroy
      out[:message] = REGISTRATION_COMPLETED
      out[:type] = :success
    else
      out[:message] = REGISTRATION_FAILED
      out[:type] = :error
    end

    out
  end
end
