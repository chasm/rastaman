class EmailValidator < ActionMailer::Base
  default from: 'admin@rastaman.com'

  def send_registration_email(registrant)
    @url = "http://localhost:3000/register/#{registrant.sign_up_code}"

    mail to: registrant.email,
      subject: "Rastaman! Please complete your registration!"
  end

  def send_password_reset_email(user)
    @url = "http://localhost:3000/reset/#{user.password_reset_code}"

    mail to: user.email,
      subject: "Rastaman! Please reset your password!"
  end
end
