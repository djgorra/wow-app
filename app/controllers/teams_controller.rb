class TeamsController < ApplicationController

    def index 
        version = params[:team][:version_id]
        if version
            teams = current_user.teams.where(version_id: version)
        else
            teams = current_user.teams
        end
        render json: teams
    end

    def create
        team = current_user.teams.create(team_params)
        version = params[:team][:version_id]
        if version
            teams = current_user.teams.where(version_id: version)
        else
            teams = current_user.teams
        end
        render json: teams
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
        if team.user_id != current_user.id
            head :unauthorized and return
        else
            team.deleted = true
            team.save
            version = params[:team][:version_id]
            if version
                teams = current_user.teams.where(version_id: version)
            else
                teams = current_user.teams
            end
            render json: teams
        end
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

    def invite
        team = Team.find_by(invite_code: params[:invite_code])
        TeamCharacter.find_or_create_by!(team_id: team.id, character_id: params[:character_id])
        render json: team
    end

    def discord_create
        user = User.find_by(battletag: params[:battle_id])
        team = user.teams.first
        render json: team.invite_code
    end

    private
    def team_params
        params.require(:team).permit(:name, :version_id, :faction)
    end

    
end