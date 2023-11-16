class DropsController < ApplicationController

    def show
        battle = Battle.find(params[:battle_id])
        item = Item.find(params[:id])
        drop = battle.drops.where(item_id: item.id).first
        wishlist_characters = []
        battle.characters.each do |c|
            c.wishlist_items.each do |i|
                if i[:id] == item.id
                    wishlist_characters << c
                end
            end
        end
        non_wishlist_characters = battle.characters - wishlist_characters
        render json: {:drop=>drop, :item=>item, :characters=>[{:title=>"In Wishlist", :data=>wishlist_characters},{:title=>"Others", :data=>non_wishlist_characters} ]}
    end

    def create
        #needs battle_id, character_id, item_id, disenchanted
        battle = Battle.find(params[:battle_id])
        character_battle = CharacterBattle.find_by(character_id: params[:character_id], battle_id: battle.id)
        Drop.create(character_battle_id: character_battle.id, item_id: params[:item_id], disenchanted: params[:disenchanted])
        render json: battle
    end

    def update
        battle = Battle.find(params[:battle_id])
        drop = Drop.find(params[:id])
        drop.update(drop_params)
        render json: battle
    end

    private

    def drop_params
        params.permit(:disenchanted, :character_battle_id)
    end

end