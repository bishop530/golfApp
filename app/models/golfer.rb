class Golfer < ActiveRecord::Base
  has_many :scores

  attr_accessor :activation_token, :reset_token
  before_create :create_activation_digest
	before_save :downcase_email
	validates :name, presence: true
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 128 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness:  { case_sensitive:  false }
  has_secure_password
  validates :password, length: { minimum: 6 }, allow_blank: true

  # Returns the hash digest of the given string
  def Golfer.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password::create(string, cost: cost)
  end

  # Returns a random token
  def Golfer.new_token
    SecureRandom.urlsafe_base64
  end

  # Returns true if the given token matches the digest
  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  # Activate an account
  def activate
    update_attribute(:activated, true)
    update_attribute(:activated_at, Time.zone.now)
  end

  # Send activation email
  def send_activation_email
    GolferMailer.account_activation(self).deliver_now
  end

  # Sets the password reset attributes
  def create_reset_digest
    self.reset_token = Golfer.new_token
    update_attribute(:reset_digest, Golfer.digest(reset_token))
    update_attribute(:reset_sent_at, Time.zone.now)
  end

  # Sends password reset email
  def send_password_reset_email
    GolferMailer.password_reset(self).deliver_now
  end

  # Returns true if a password reset has expired
  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end

private

  # Convert email to lowercase
  def downcase_email
    self.email = email.downcase
  end

  # Create and assigns the activation token and digest
  def create_activation_digest
    self.activation_token = Golfer.new_token
    self.activation_digest = Golfer.digest(activation_token)
  end

end
