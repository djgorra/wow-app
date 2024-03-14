class TeamCodeCharacter < ApplicationRecord
    belongs_to :team
    belongs_to :character

    validates_uniqueness_of :team_id, :scope => :character_id
end