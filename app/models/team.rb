class Team < ApplicationRecord
    belongs_to :user
    has_many :runs
    has_many :team_characters, :class_name => "TeamCharacter", unique: true
    has_many :characters, through: :team_characters

    def as_json(options = {})
        out = {}
        [:id, :name, :user_id, :characters].each do |key|
            out[key] = self.send(key)
        end
        out
    end
end
