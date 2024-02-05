class BattlesController < ApplicationController
    def create
        unless battle = Battle.find_by(run_id: params[:run_id], boss_id: params[:boss_id])
            battle = Battle.create(run_id: params[:run_id], boss_id: params[:boss_id])
            battle.run.team.characters.each do |c|
                CharacterBattle.create(character_id: c.id, battle_id: battle.id)
            end
        end
        render json: battle.reload.as_json(:include_items=>true)
    end

    def show
        battle = Battle.find(params[:id])
        render json: battle.as_json(:include_items=>true)
    end

end