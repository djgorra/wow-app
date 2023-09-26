FactoryBot.define do
  factory :team do
    name { "MyString" }
    user { create(:user) }
  end
end
