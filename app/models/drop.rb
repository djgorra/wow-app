class Drop < ApplicationRecord
    belongs_to :character_battle
    has_one :item
end
