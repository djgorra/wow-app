class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, 
         :jwt_authenticatable, jwt_revocation_strategy: JwtDenylist

  has_one_attached :avatar
  has_many :characters, dependent: :destroy
  validates_presence_of   :email, if: :email_required?
  validates_presence_of :password, if: :password_required?
  has_many :friends
  has_many :teams
  validates :password, length: { minimum: 6 }, allow_blank: true, if: :password_required?
  
  def friendlist
    friends.reload.map{|friend| friend.friend.friend_json}
  end

  def email_required?
    battletag.blank?
  end

  def password_required?
    battletag.blank? && new_record?
  end
  
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

  def avatar_url
    if avatar.attached?
      Rails.application.routes.url_helpers.rails_blob_url(avatar, only_path: true)
    else
      nil
    end
  end

  def friend_json
    {:id=>id, 
      :username=>username, 
      :battletag=>battletag, 
      :characters=>characters, 
      :avatar_url=>avatar_url}
  end

  def as_json(options = {})
    out = {:access_token=>generate_jwt, :expires_at=>User.expiration_time.from_now.to_i, :user=>{}}
     [:id, :email, :username, :avatar_url, :battletag].each do |key|
      out[:user][key] = self.send(key)
    end
    out[:characters]=characters.as_json
    out
  end

  def self.seed
    25.times do |i|
      unless User.find_by(email: "test#{i}@test")
        User.create(
          email: "test#{i}@test",
          username: "test#{i}",
          password: "test#{i}",
          password_confirmation: "test#{i}",
          battletag: "test#{i}#1234"
        )
      end

      unless i==0 #skips first user, adds all subsequent users to user0's friendlist
        Friend.create(
          user_id: User.find_by(email: "test0@test").id,
          friend_id: User.last.id
        )
      end
    end

    i=User.last.id
    Specialization.all.each do |s| 
      unless Character.find_by(name: "#{s.name}#{s.character_class.name}")
        Character.create(
          name: "#{s.name}#{s.character_class.name}",
          user_id: i,
          character_class_id: s.character_class_id,
          primary_spec_id: s.id,
          secondary_spec_id: s.character_class.specializations.last.id,
          race: rand(4),
          gender: rand(2)
        )
      end
      i-=1
    end

  end

end