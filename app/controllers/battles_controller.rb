class BattlesController < ApplicationController
    def create
        if battle = Battle.create(run_id: params[:run_id], boss_id: params[:boss_id])
            battle.run.team.characters.each do |c|
                CharacterBattle.create(character_id: c.id, battle_id: battle.id)
            end
        else 
            battle = Battle.find_by(run_id: params[:run_id], boss_id: params[:boss_id])
        end
        render json: battle
    end

    def show
        battle = Battle.find(params[:id])
        render json: battle
    end

end