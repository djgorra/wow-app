class CharacterClass < ApplicationRecord
    has_many :specializations
    has_many :characters

    def label
      name.titlecase
    end

    def value
      id
    end

    def self.seed 
        spec_list =   [
            {
                name: "Blood",
                char_class: "death_knight",
                role: "Tank",
                buffs: ["Str/Agi", "AP%"],
                debuffs: ["AtkSpd"],
            },
        
            {
                name: "Frost",
                char_class: "death_knight",
                role: "mDPS",
                buffs: ["Str/Agi", "mHaste"],
                debuffs: ["AtkSpd"],
            },
        
            {
                name:"Unholy",
                char_class:"death_knight",
                role:"mDPS",
                buffs:["Str/Agi"],
                debuffs:["AtkSpd", "sDMG"]
            },
        
            {
                name:"Elemental",
                char_class:"shaman",
                role:"rDPS",
                buffs:["Str/Agi", "BL", "MP5", "sCrit", "sHaste", "SP"],
                debuffs:["crit"]
            },
        
            {
                name:"Enhancement",
                char_class:"shaman",
                role:"mDPS",
                buffs:["Str/Agi", "BL", "MP5", "AP%", "sHaste"],
                debuffs:[]
            },
        
            {
                name:"Resto",
                char_class:"shaman",
                role:"Heal",
                buffs:["Str/Agi", "BL", "MP5", "Armor%", "sHaste"],
                debuffs:[]
            },
        
            {
                name:"Holy",
                char_class:"paladin",
                role:"Heal",
                buffs:["AP", "MP5", "Stat%"],
                debuffs:["HRestore", "MRestore"]
            },
        
            {
                name:"Protection",
                char_class:"paladin",
                role:"Tank",
                buffs:["AP", "MP5", "Stat%", "DR%", "Heal%"],
                debuffs:["HRestore", "MRestore", "AtkSpd", "crit"]
            },
        
            {
                name:"Retribution",
                char_class:"paladin",
                role:"mDPS",
                buffs:["AP", "MP5", "Stat%", "Dmg%", "Haste%", "replen"],
                debuffs:["HRestore", "MRestore", "crit"]
            },
        
            {
                name:"Arms",
                char_class:"warrior",
                role:"mDPS",
                buffs:["AP", "HP"],
                debuffs:["AP", "BldDmg", "-Heal", "AtkSpd", "PhysDmg%", "ArmorMaj"]
            },
        
            {
                name:"Fury",
                char_class:"warrior",
                role:"mDPS",
                buffs:["AP", "HP", "mCrit"],
                debuffs:["AP", "AtkSpd", "ArmorMaj"]
            },
        
            {
                name:"Protection",
                char_class:"warrior",
                role:"Tank",
                buffs:["AP", "HP"],
                debuffs:["AP", "AtkSpd", "ArmorMaj"]
            },
        
            {
                name:"Balance",
                char_class:"druid",
                role:"rDPS",
                buffs:["Haste%", "sCrit", "motw"],
                debuffs:["ArmorMin", "Miss%", "sDMG", "sHit"]
            },
        
            {
                name:"Feral(Cat)",
                char_class:"druid",
                role:"mDPS",
                buffs:["mCrit", "motw"],
                debuffs:["ArmorMin", "BldDmg"]
            },
        
            {
                name:"Feral(Bear)",
                char_class:"druid",
                role:"Tank",
                buffs:["mCrit", "motw"],
                debuffs:["ArmorMin", "AtkSpd", "AP"]
            },
        
            {
                name:"Resto",
                char_class:"druid",
                role:"Heal",
                buffs:["Heal%", "motw"],
                debuffs:["ArmorMin"]
            },
        
            {
                name:"Arcane",
                char_class:"mage",
                role:"rDPS",
                buffs:["Dmg%", "int"],
                debuffs:[]
            },
        
            {
                name:"Fire",
                char_class:"mage",
                role:"rDPS",
                buffs:["int"],
                debuffs:["sCrit"]
            },
        
            {
                name:"Frost",
                char_class:"mage",
                role:"rDPS",
                buffs:["int", "replen"],
                debuffs:["sCrit"]
            },
        
            {
                name:"Assassination",
                char_class:"rogue",
                role:"mDPS",
                buffs:[],
                debuffs:["ArmorMaj", "cSpeed", "-Heal", "crit"]
            },
        
            {
                name:"Combat",
                char_class:"rogue",
                role:"mDPS",
                buffs:[],
                debuffs:["ArmorMaj", "cSpeed", "-Heal", "PhysDmg%"]
            },
        
            {
                name:"Subtlety",
                char_class:"rogue",
                role:"mDPS",
                buffs:[],
                debuffs:["ArmorMaj", "cSpeed", "-Heal"],
            },
        
            {
                name:"Beast Mastery",
                char_class:"hunter",
                role:"rDPS",
                buffs:["Dmg%"],
                debuffs:["-Heal", "Miss%"]
            },
        
            {
                name:"Marksmanship",
                char_class:"hunter",
                role:"rDPS",
                buffs:["AP%"],
                debuffs:["-Heal", "Miss%"],
            },
        
            {
                name:"Survival",
                char_class:"hunter",
                role:"rDPS",
                buffs:["replen"],
                debuffs:["-Heal", "Miss%"]
            },
        
            {
                name:"Discipline",
                char_class:"priest",
                role:"Heal",
                buffs:["Armor%", "DR%", "spirit", "stam"],
                debuffs:[]
            },
        
            {
                name:"Holy",
                char_class:"priest",
                role:"Heal",
                buffs:["Armor%", "spirit", "stam"],
                debuffs:[]
            },
        
            {
                name:"Shadow",
                char_class:"priest",
                role:"rDPS",
                buffs:["spirit", "stam", "replen"],
                debuffs:["sHit"]
            },
        
            {
                name:"Affliction",
                char_class:"warlock",
                role:"rDPS",
                buffs:["int", "spirit"],
                debuffs:["ArmorMin", "AP", "cSpeed", "sDMG"]
            },
        
            {
                name:"Demonology",
                char_class:"warlock",
                role:"rDPS",
                buffs:["SP"],
                debuffs:["ArmorMin", "AP", "cSpeed", "sDMG", "sCrit"]
            },
        
            {
                name:"Destruction",
                char_class:"warlock",
                role:"rDPS",
                buffs:["HP", "replen"],
                debuffs:["ArmorMin", "AP", "cSpeed", "sDMG"]
            }
        ];

        spec_list.each do |spec|
            if !CharacterClass.find_by(name: spec[:char_class])
                CharacterClass.create(name:spec[:char_class])
            end #i.e. if class doesn't exist then create it

            Specialization.create(
                name:spec[:name],
                character_class_id:CharacterClass.find_by(name: spec[:char_class]).id,
                role:spec[:role],
                buffs:spec[:buffs],
                debuffs:spec[:debuffs]
            )
        end
        
    end

    def as_json(options = {})
        out = {}
        [:id, :name, :label, :value].each do |key|
            out[key] = self.send(key)
        end
        out[:specializations]=specializations.as_json
        out
    end
end