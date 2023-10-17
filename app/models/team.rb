class Team < ApplicationRecord
    belongs_to :user
    has_many :runs
    has_many :team_characters, :class_name => "TeamCharacter"
    has_many :characters, through: :team_characters

    def spells
        characters.map{|character| character.primary_spec.spells}.flatten
    end

    def as_json(options = {})
        out = {}
        [:id, :name, :user_id, :characters, :spells].each do |key|
            out[key] = self.send(key)
        end
        out
    end
end
