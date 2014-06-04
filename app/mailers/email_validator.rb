class EmailValidator < ActionMailer::Base
  default from: 'admin@rastaman.com'

  def complete_registration(registrant)
    @registrant = registrant
    @url = "http://localhost:3000/register/#{@registrant.sign_up_code}"

    mail to: @registrant.email,
      subject: "Rastaman! Please complete your registration!"
  end
end
