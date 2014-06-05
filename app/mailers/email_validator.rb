class EmailValidator < ActionMailer::Base
  default from: 'admin@rastaman.com'

  def complete_registration(registrant)
    @url = "http://localhost:3000/register/#{registrant.sign_up_code}"

    mail to: registrant.email,
      subject: "Rastaman! Please complete your registration!"
  end

  # def password_reset(user)
    # @url = "http://localhost:3000/reset/#{user.reset_code}"
    #
    # mail to: user.email,
    #   subject: "Rastaman! Please reset your password!"
  # end
end
