class User < ActiveRecord::Base
  has_many :gifs
  
  attr_accessor :password
  before_save :encrypt_password_and_lowercase_username
  
  validates_confirmation_of :password
  validates :username,  presence: true, uniqueness: { case_sensitive: false }
  validates :email,  presence: true, uniqueness: { case_sensitive: false }
  validates_presence_of :password, :on => :create
  validates :password, length: { minimum: 6 }
  
  def self.authenticate(username, password)
    user = find_by_username(username.downcase)
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.salt)
      user
    else
      nil
    end
  end
  
  def encrypt_password_and_lowercase_username
    self.username = username.downcase 
    if password.present?
      self.salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, salt)
    end
  end
  
  def self.create_user(username, email, password, password_confirmation)
    salt = BCrypt::Engine.generate_salt
    password_hash = BCrypt::Engine.hash_secret(password, salt)
    user = User.new(username: username, email:email, password_hash:password_hash, salt:salt)
    user.save
  end
end
