class ItemsController < ApplicationController

    def show
        battle = Battle.find(params[:battle_id])
        item = Item.find(params[:id])
        wishlist_characters = []
        battle.characters.each do |c|
            c.wishlist_items.each do |i|
                if i[:id] == item.id
                    wishlist_characters << c
                end
            end
        end
        non_wishlist_characters = battle.characters - wishlist_characters
        render json: {item: item, wishlist_characters: wishlist_characters, non_wishlist_characters: non_wishlist_characters}
    end


end