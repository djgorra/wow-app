class Run < ApplicationRecord
    belongs_to :team, optional: true
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
        return @completed if @completed
        @completed = []
        raid.bosses.each do |boss|
            battles.each do |battle|
                if battle.boss_id == boss.id
                    @completed << boss
                end
            end
        end
        @completed
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

    def summary
        out = []
        battles.each do |b|
            name = b.boss.name
            section = {:title=>b.boss.name, :data=>[]}
            b.drops.each do |d|
                section[:data].push(d)
            end
            out.push(section)
        end
        out
    end

    def mark_completed
        if self.completed == false
            self.completed = true
            self.save
        else
            self.completed = false
            self.save
        end
    end

    def self.mark_all_completed
        Run.where(:completed=>false).each do |run|
            if run.battles.count == 0 || run.drops.count == 0 #i.e. if there are no battles or drops, delete the run
                run.delete
                next
            end
            run.mark_completed
        end
    end

    def as_json(options = {})
        out = {}
        [:id, :raid_id, :team_id, :raid_name, :timestamp, :completed_bosses, :remaining_bosses, :battles].each do |key|
            out[key] = self.send(key)
        end
        out
    end
end