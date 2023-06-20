FactoryBot.define do
  factory :user do
    email { "user#{Time.now.to_f}#{rand(1000)}@wowapp.com" }
    password  { "[FILTERED]" }
    password_confirmation  { "[FILTERED]" }
    username {"MyUserName"}
    
  end

end
