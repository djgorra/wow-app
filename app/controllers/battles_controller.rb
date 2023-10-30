class BattlesController < ApplicationController
    def character_battles
        battle = Battle.find(params[:id])
        battle.run.team.characters.each do |c|
            CharacterBattle.create(character_id: c.id, battle_id: params[:id])
        end
        #drop = Drop.create(character_battle_id: params[:character_battle_id], item_id: params[:item_id])
        render json: battle
    end

    def create_drop
        battle = Battle.find(params[:id])
        character = Character.find(params[:character_id])
        character_battle = CharacterBattle.find_by(character_id: character.id, battle_id: battle.id)
        Drop.create(character_battle_id: character_battle.id, item_id: params[:item_id])
        render json: battle
    end
end