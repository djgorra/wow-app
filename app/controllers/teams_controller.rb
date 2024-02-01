class TeamsController < ApplicationController

    def index 
        if params[:version_id]
            teams = current_user.teams.where(version_id: params[:version_id])
        else
            teams = current_user.teams
        end
        render json: teams
    end

    def create
        team = current_user.teams.create(team_params)
        render json: current_user.teams
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
        TeamCharacter.find_or_create_by!(team_id: team.id, character_id: params[:character_id])
        render json: team
    end

    def remove_characters
        team = Team.find(params[:id])
        team.characters.delete(Character.find(params[:character_id]))
        render json: team
    end

    private
    def team_params
        params.require(:team).permit(:name)
    end

    
end