class Run < ApplicationRecord
    belongs_to :team
    belongs_to :raid
    has_many :team_characters
    has_many :battles

    def raid_name
        raid.name
    end
    
    def timestamp
        created_at.strftime("%m/%d/%y")
    end

    def drops
        out = []
        battles.each do |b|
            b.drops.each do |d|
                out.push(d)
            end
        end
        out
    end

    def as_json(options = {})
        out = {}
        [:id, :raid_id, :team_id, :raid_name, :timestamp, :battles].each do |key|
            out[key] = self.send(key)
        end
        out
    end
end