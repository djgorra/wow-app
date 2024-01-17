class RunsController < ApplicationController
    before_action :set_team
    def index
        render json: @team.runs.where(completed: false).order(created_at: :desc)
    end

    def completed_index
        render json: @team.runs.where(completed: true).order(created_at: :desc)
    end

    def mark_completed
        run = Run.find(params[:id])
        run.mark_completed
        render json: run
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