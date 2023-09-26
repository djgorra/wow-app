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

    def show
        run = Run.find(params[:id])
        render json: run
    end

    def autobattle

    end

    def drops
        run = Run.find(params[:id])
        render json: run.drops
    end

    private
    def run_params
        params.require(:run).permit(:team_id, :raid_id)
    end

    def set_team
        @team = Team.find(params[:team_id])
    end
end