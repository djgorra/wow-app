class Drop < ApplicationRecord
    belongs_to :character_battle
    belongs_to :item

    before_create :update_wishlist

    def update_wishlist
        if self.item && !self.disenchanted
            character_item = CharacterItem.find_by(character_id: self.character_battle.character.id, item_id: self.item.id)
            if character_item
                character_item.update_attribute(:assigned, true)
            end
            #i.e. if the item is in the character's wishlist, mark it as assigned
        end
    end
end
