class Run < ApplicationRecord
    belongs_to :team
    belongs_to :raid
    has_many :team_characters
    has_many :battles
    has_many :drops, through: :battles

    def raid_name
        raid.name
    end

    def as_json(options = {})
        out = {}
        [:id, :raid_id, :raid_name, :created_at, :team_characters, :battles].each do |key|
            out[key] = self.send(key)
        end
    end
end