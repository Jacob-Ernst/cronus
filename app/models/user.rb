class User < ActiveRecord::Base

  has_secure_password

  # Validation
  validates :email, presence: true, uniqueness: true
  validates_presence_of :password_digest

  # Associations
  has_many :goals

  def generate_auth_token
    payload = { user_id: self.id }
    AuthToken.encode(payload)
  end

end
