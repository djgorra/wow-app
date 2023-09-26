class Battle < ApplicationRecord
    belongs_to :run
    has_many :characters
    has_many :character_battles
    has_many :drops, through: :character_battles
end