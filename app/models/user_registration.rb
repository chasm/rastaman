class UserRegistration

  def initialize()
  end

  def send_registration_email(email)
    registrant = Registrant.new( email: email )

    out = {}

    if registrant.save
      EmailValidator.complete_registration(registrant).deliver

      out[:message] = "We sent you an email to complete your registration."
      out[:type] = :success
    else
      out[:message] = "Registration failed. Please check your email address."
      out[:type] = :error
    end

    out
  end

  def complete_user_registration(registrant, attrs)
    out = {
      user: User.new( attrs.merge(email: registrant.email) )
    }

    if out[:user].save
      registrant.destroy
      out[:message] = "Thank you for completing your registration. Welcome!"
      out[:type] = :success
    else
      out[:message] = "Unable to complete your registration. Please check your form."
      out[:type] = :error
    end

    out
  end
end
