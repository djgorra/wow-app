class CharacterBattle < ApplicationRecord
    belongs_to :character
    belongs_to :battle
    has_many :drops
end