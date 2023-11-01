class CharacterBattle < ApplicationRecord
    belongs_to :character
    belongs_to :battle
    has_many :drops

    def as_json(options = {})
    out = {}
    [:character, :drops].each do |key|
        out[key] = self.send(key)
    end
    out
end
end