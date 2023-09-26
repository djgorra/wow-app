class TeamsController < ApplicationController

    def index 
        teams = current_user.teams
        render json: teams
    end

    def create
        team = Team.create(team_params)
        render json: team
    end

    def show
        team = Team.find(params[:id])
        render json: team
    end

    def update
        team = Team.find(params[:id])
        team.update(team_params)
        render json: team
    end

    def destroy
        team = Team.find(params[:id])
        team.destroy
        render json: team
    end

    def add_characters
        team = Team.find(params[:id])
        params[:character_ids].each do |id|
            TeamCharacter.create(team_id: team.id, character_id: id)
        end
        render json: team
    end

    def remove_characters
        team = Team.find(params[:id])
        team.characters.delete(Character.find(params[:character_ids]))
        render json: team
    end

    private
    def team_params
        params.require(:team).permit(:name, :user_id)
    end

    
end