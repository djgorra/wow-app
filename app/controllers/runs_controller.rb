class RunsController < ApplicationController
    before_action :set_team
    def index
        render json: @team.runs.order(created_at: :desc)
    end

    def create
        run = Run.create(run_params)
        render json: run
    end

    def show
        run = Run.find(params[:id])
        render json: run
    end

    def summary
        run = Run.find(params[:id])
        render json: run.summary
    
    end

    private

    def run_params
        params.permit(:team_id, :raid_id)
    end

    def set_team
        @team = Team.find(params[:team_id])
    end
end