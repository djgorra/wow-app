FactoryBot.define do
  factory :character do
    name { "MyString" }
    character_class_id { 1 }
    primary_spec_id { 1 }
    secondary_spec_id { 2 }
    race { 1 }
    gender { 1 }
  end
end
