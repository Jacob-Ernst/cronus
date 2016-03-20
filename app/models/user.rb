class User < ActiveRecord::Base
# User Fields:
# - string :first_name
# - string :last_name
# - string :email, uniqueness: true
# - string :password_digest


  has_secure_password

  # Validation
  validates :email, presence: true, uniqueness: true
  validates_presence_of :password_digest
  validates_presence_of :first_name
  validates_presence_of :last_name


  # Associations
  has_many :goals, dependent: :destroy

  def generate_auth_token
    payload = { user_id: self.id }
    AuthToken.encode(payload)
  end

end
