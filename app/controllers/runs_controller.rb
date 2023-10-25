class RunsController < ApplicationController
    before_action :set_team
    def index
        runs = @team.runs
        render json: runs
    end

    def create
        run = Run.create(run_params)
        render json: run
    end

    def battle
        run = Run.find(params[:id])
        battle = Battle.create(run_id: run.id, boss_id: params[:boss_id])
        run.team.characters.each do |c|
            CharacterBattle.create(character_id: c.id, battle_id: battle.id)
        end
        render json: run
    end

    def create_drop
        run = Run.find(params[:id])
        drop = Drop.create(character_battle_id: params[:character_battle_id], item_id: params[:item_id])
        render json: run
    end

    def show
        run = Run.find(params[:id])
        render json: run
    end

    # def drops
    #     run = Run.find(params[:id])
    #     render json: run.drops
    # end

    private

    def run_params
        params.require(:run).permit(:team_id, :raid_id)
    end

    def set_team
        @team = Team.find(params[:team_id])
    end
end