class CharacterItem < ApplicationRecord
    belongs_to :character
    belongs_to :item

    scope :wishlist, -> { where(assigned: false) }
end