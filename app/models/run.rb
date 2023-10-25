class Run < ApplicationRecord
    belongs_to :team
    belongs_to :raid
    has_many :team_characters
    has_many :battles
    has_many :drops, through: :battles

    def raid_name
        raid.name
    end

    def name
        "#{raid.name} - #{created_at.strftime("%m/%d/%Y")}"
    end

    def as_json(options = {})
        out = {}
        [:id, :name, :raid_id, :raid_name, :created_at, :battles].each do |key|
            out[key] = self.send(key)
        end
        out
    end
end