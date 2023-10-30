class Battle < ApplicationRecord
    belongs_to :run
    belongs_to :boss
    has_many :characters
    has_many :character_battles
    has_many :drops, through: :character_battles

    def as_json(options = {})
        out = {}
        [:drops].each do |key|
            out[key] = self.send(key)
        end
        out
    end
end