class Battle < ApplicationRecord
    belongs_to :run
    belongs_to :boss
    has_many :character_battles
    has_many :drops, through: :character_battles
    validates_uniqueness_of :run_id, :scope => :boss_id

    def characters
        out = []
        character_battles.map do |cb|
            out.push(cb.character)
        end
        out
    end
    
    
    def as_json(options = {})
        out = {}
        [:id, :characters, :drops].each do |key|
            out[key] = self.send(key)
        end
        out[:boss]={:id=>boss.id, :name=>boss.name}
        if options && options.has_key?(:include_items) && options[:include_items]
            out[:boss][:items] = boss.items
        end
        out
    end
end