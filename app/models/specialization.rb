class Specialization < ApplicationRecord
    belongs_to :character_class
    enum :role => { "Tank"=>0, "Heal"=>1, "rDPS"=>2, "mDPS"=>3}
    alias_attribute :value, :id
    alias_attribute :label, :name

    def as_json(options = {})
    out = {}
     [:label, :role, :buffs, :debuffs, :value, :character_class_id].each do |key|
      out[key] = self.send(key)
    end
    out
   end
  
end
