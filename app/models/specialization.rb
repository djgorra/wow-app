class Specialization < ApplicationRecord
    belongs_to :character_class
    has_many :spec_spells
    has_many :spells, through: :spec_spells
    enum :role => { "Tank"=>0, "Heal"=>1, "rDPS"=>2, "mDPS"=>3}
    alias_attribute :value, :id
    alias_attribute :label, :name

    def icon_path
      "/specs/#{name.gsub(" ", "").gsub("_", "") + character_class.name.gsub(" ", "").gsub("_", "")}.png"
    end

    def buffs 
      spells.map{|spell| spell.buff}.flatten
    end

    def as_json(options = {})
      out = {}
      [:label, :role, :buffs, :value, :character_class_id, :icon_path].each do |key|
        out[key] = self.send(key)
      end
      out
    end
  
end
