class Run < ApplicationRecord
    belongs_to :team
    belongs_to :raid
    has_many :team_characters
    has_many :characters, through: :team_characters
    has_many :battles

    def raid_name
        raid.name
    end
    
    def timestamp
        created_at.strftime("%m/%d/%y")
    end

    def completed_bosses
        completed = []
        raid.bosses.each do |boss|
            battles.each do |battle|
                if battle.boss_id == boss.id
                    completed << boss
                end
            end
        end
        completed
    end

    def remaining_bosses
        raid.bosses - completed_bosses
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
        [:id, :raid_id, :team_id, :raid_name, :timestamp, :completed_bosses, :remaining_bosses, :battles].each do |key|
            out[key] = self.send(key)
        end
        out
    end
end