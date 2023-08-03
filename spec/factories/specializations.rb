FactoryBot.define do
    factory :specialization do
        name { "Arms" }
        character_class_id { 1 }
        role { 3 }
        buffs { ["MyBuffs"] }
        debuffs { ["MyDebuffs"] }
    end
end