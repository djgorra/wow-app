class Specialization < ApplicationRecord
    belongs_to :character_class
    enum :role => { "Tank"=>0, "Heal"=>1, "rDPS"=>2, "mDPS"=>3}

    def as_json(options = {})
    out = {}
     [:name, :role, :buffs, :debuffs].each do |key|
      out[key] = self.send(key)
    end
    out
   end
  
end
