Registrant.destroy_all
User.destroy_all

Registrant.create([
  {
    email: "amy@example.com",
    sign_up_code: SecureRandom.urlsafe_base64,
    sign_up_expires_at: Time.now + 2.hours
  },
  {
    email: "bill@example.com",
    sign_up_code: SecureRandom.urlsafe_base64,
    sign_up_expires_at: Time.now + 2.hours
  },
  {
    email: "charlie@example.com",
    sign_up_code: SecureRandom.urlsafe_base64,
    sign_up_expires_at: Time.now + 2.hours
  },
  {
    email: "debbie@example.com",
    sign_up_code: SecureRandom.urlsafe_base64,
    sign_up_expires_at: Time.now + 2.hours
  },
  {
    email: "ed@example.com",
    sign_up_code: SecureRandom.urlsafe_base64,
    sign_up_expires_at: Time.now + 2.hours
  }
])

User.create(
  email: "chas@munat.com",
  password: "123",
  password_confirmation: "123"
)
