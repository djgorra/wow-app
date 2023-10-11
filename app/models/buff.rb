class Buff < ApplicationRecord
    has_many :spells
    has_many :specializations, through: :spells

    def self.seed
        buffList = [
            {name: "Bloodlust/Heroism", effect_type:"buff"},
            {name: "5% Spell Haste", effect_type:"buff"},
            {name: "5% Physical Crit", effect_type:"buff"},
            {name: "10% Attack Power", effect_type:"buff"},
            {name: "6% Healing", effect_type:"buff"},
            {name: "Blessing of Kings", effect_type:"buff"},
            {name: "5% Spell Crit", effect_type:"buff"},
            {name: "20% Melee Haste", effect_type:"buff"},
            {name: "3% Damage", effect_type:"buff"},
            {name: "Intellect", effect_type:"buff"},
            {name: "20% Melee Haste", effect_type:"buff"},
            {name: "Spell Power", effect_type:"buff"},
            {name: "Attack Power", effect_type:"buff"},
            {name: "Health", effect_type:"buff"},
            {name: "Spirit", effect_type:"buff"},
            {name: "Stamina", effect_type:"buff"},
            {name: "3% Haste", effect_type:"buff"},
            {name: "Gift of the Wild", effect_type:"buff"},
            {name: "Strength/Agility", effect_type:"buff"},

            {name: "Power Infusion", effect_type:"external_buff"},
            {name: "Unholy Frenzy", effect_type:"external_buff"},
            {name: "Focus Magic", effect_type:"external_buff"},
            {name: "Tricks of the Trade", effect_type:"external_buff"},

            {name:"10% Damage Reduction", effect_type:"damage_reduction"},
            {name:"3% Damage Reduction", effect_type:"damage_reduction"},
            {name:"Divine Guardian", effect_type:"damage_reduction"},
            {name:"Pain Suppression", effect_type:"damage_reduction"},
            {name:"Guardian Spirit", effect_type:"damage_reduction"},

            { name: "5% Armor Reduction", effect_type: "debuff" },
            { name: "3% Physical Hit Reduction", effect_type: "debuff" },
            { name: "20% Armor Reduction", effect_type: "debuff" },
            { name: "20% Attack Speed Reduction", effect_type: "debuff" },
            { name: "+5% Spell Crit", effect_type: "debuff" },
            { name: "+3% Crit", effect_type: "debuff" },
            { name: "Attack Power Reduction", effect_type: "debuff" },
            { name: "+4% Physical Damage", effect_type: "debuff" },
            { name: "+3% Spell Hit", effect_type: "debuff" },
            { name: "+30% Bleed Damage", effect_type: "debuff" },
            { name: "+13% Spell Damage", effect_type: "debuff" },

            { name: "Mana Tide Totem", effect_type: "mana_regeneration" },
            { name: "Innervate", effect_type: "mana_regeneration" },
            { name: "Replenishment", effect_type: "mana_regeneration" },
            { name: "Rapture", effect_type: "mana_regeneration" },
            { name: "Revitalize", effect_type: "mana_regeneration" },
            { name: "Mana Regen", effect_type: "mana_regeneration" },
            { name: "Judgement of Wisdom", effect_type: "mana_regeneration" },
            { name: "Hymn of Hope", effect_type: "mana_regeneration" },

            { name: "Vampiric Embrace", effect_type: "health_regeneration" },
            { name: "Judgement of Light", effect_type: "health_regeneration" },
            { name: "Improved Leader of the Pack", effect_type: "health_regeneration" },
            { name: "Healing Stream Totem", effect_type: "health_regeneration" }
        ]

        buffList.each do |buff|
            Buff.create(buff)
        end

    end
end