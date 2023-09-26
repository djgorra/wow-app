class TeamCharacter < ApplicationRecord
    belongs_to :team
    belongs_to :character
end