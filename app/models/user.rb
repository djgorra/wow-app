class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, 
         :jwt_authenticatable, jwt_revocation_strategy: JwtDenylist
  validates :username, uniqueness: { case_sensitive: false }, presence: true, allow_blank: false, format: { with: /\A[a-zA-Z0-9]+\z/ }

  has_one_attached :avatar
  
  def self.expiration_time
    60.days
  end

  def self.secret
    Rails.application.secret_key_base
  end

  def generate_jwt
    JWT.encode(
      { 
        id: id,
        exp:User.expiration_time.from_now.to_i,
        jti: SecureRandom.uuid
      },
      User.secret
    )
  end

  def as_json(options = {})
    out = {:access_token=>generate_jwt, :expires_at=>User.expiration_time.from_now.to_i, :user=>{}}
     [:id, :email, :username].each do |key|
      out[:user][key] = self.send(key)
    end
    out
  end


end