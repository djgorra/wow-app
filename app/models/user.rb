class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, 
         :jwt_authenticatable, jwt_revocation_strategy: JwtDenylist
  validates :username, uniqueness: { case_sensitive: false }, presence: true, allow_blank: false, format: { with: /\A[a-zA-Z0-9]+\z/ }
  
  def expiration_time
    60.days.from_now.to_i
  end

  def generate_jwt
    JWT.encode(
      { 
        id: id,
        exp:expiration_time
      },
      Rails.application.secrets.secret_key_base
    )
  end

  def as_json(options = {})
    out = {:access_token=>generate_jwt, :user=>{}}
     [:email, :username].each do |key|
      out[:user][key] = self.send(key)
    end
    out
  end


end