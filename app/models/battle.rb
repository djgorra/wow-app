class Battle < ApplicationRecord
    belongs_to :run
    belongs_to :boss
    has_many :character_battles
    has_many :drops, through: :character_battles

    def characters
        out = []
        character_battles.map do |cb|
            out.push(cb.character)
        end
        out
    end
    
    
    def as_json(options = {})
        out = {}
        [:characters, :drops].each do |key|
            out[key] = self.send(key)
        end
        out
    end
end