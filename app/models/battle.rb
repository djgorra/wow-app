class Battle < ApplicationRecord
    belongs_to :run
    belongs_to :boss
    has_many :character_battles
    has_many :drops, through: :character_battles
    validates_uniqueness_of :run_id, :scope => :boss_id

    def characters
        out = []
        character_battles.map do |cb|
            out.push(cb.character)
        end
        out
    end
    
    
    def as_json(options = {})
        out = {}
        [:id, :characters, :drops, :boss].each do |key|
            out[key] = self.send(key)
        end
        out
    end
end