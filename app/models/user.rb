class User
  include Mongoid::Document
  include Mongoid::Timestamps

  TIME_UNTIL_EXPIRE = 1.day

  before_save :encrypt_password if :password
  before_save :downcase_email

  attr_accessor :password, :password_confirmation

  field :email
  field :salt
  field :fish
  field :password_reset_code
  field :password_reset_expires_at, type: Time

  validates :email, presence: true, format: { with: EMAIL_REGEX }, uniqueness: true
  validates :password, confirmation: true

  def self.find_by_code(password_reset_code)
    User.where( :password_reset_expires_at.lt => Time.now ).each do |user|
      user.clear_reset
    end

    if user = User.find_by( :password_reset_code => password_reset_code )
      user.password_reset_expires_at = Time.now + TIME_UNTIL_EXPIRE
      user.save
      user
    end
  end

  def authenticate(password)
    self.fish == BCrypt::Engine.hash_secret(password, self.salt)
  end

  def self.authenticate(email, password)
    user = User.find_by( email: email )

    user if user && user.authenticate(password)
  end

  def set_reset
    self.password_reset_code = SecureRandom.urlsafe_base64
    self.password_reset_expires_at = Time.now + TIME_UNTIL_EXPIRE
    self.save
  end

  def clear_reset
    self.unset(:password_reset_code)
    self.unset(:password_reset_expires_at)
    self.save
  end

  protected

  def encrypt_password
    self.salt = BCrypt::Engine.generate_salt
    self.fish = BCrypt::Engine.hash_secret(password, self.salt)
  end

  def downcase_email
    self.email.downcase!
  end
end
