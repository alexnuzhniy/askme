class User < ApplicationRecord

  #Параметры модуля шифрования пароля
  ITERATIONS = 20000
  DIGEST = OpenSSL::Digest::SHA256.new

  has_many :questions

  validates :email, :username, presence: true
  validates :email, :username, uniqueness: true
  validates :email, email_format: { message: "doesn't look like an email address" }
  validates :username, length: { maximum: 40 }
  validates_format_of :username, :with => /[a-z\d_]+/i

  attr_accessor :password

  #валидировать пароль только при создании
  validates_presence_of :password, on: :create
  validates_confirmation_of :password

  #callback т е encrypt_password будет вызываться перед сохранием объекта в базу
  before_save :encrypt_password

  def encrypt_password
    if self.password.present?
      self.password_salt = User.hash_to_string(OpenSSL::Random.random_bytes(16))
      self.password_hash = User.hash_to_string(
        OpenSSL::PKCS5.pbkdf2_hmac(self.password, self.password_salt, ITERATIONS, DIGEST.length, DIGEST)
      )
    end
  end

  def self.hash_to_string(password_hash)
    password_hash.unpack('H*')[0]
  end

  def self.authenticate(email, password)
    user = find_by(email: email)

    if user.present? && user.password_hash == User.hash_to_string(OpenSSL::PKCS5.pbkdf2_hmac(password, user.password_salt, ITERATIONS, DIGEST.length, DIGEST))
      user
    else
      nil
    end
  end

=begin
  before_validation :downcase_username

  def downcase_username
    self.username.downcase!
  end
=end
end
