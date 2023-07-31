class Specialization < ApplicationRecord
    belongs_to :character_class
    enum :role => { "Tank"=>0, "Heal"=>1, "rDPS"=>2, "mDPS"=>3}

    def self.seed

    end
  
end
