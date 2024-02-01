class RaidsController < ApplicationController

    def index 
        if params[:version_id]
            raids = Raid.where(version_id: params[:version_id])
        else
            raids = Raid.all
        end
        render json: raids
    end

    def items
        raid = Raid.find(params[:id])
        render json: raid.items.to_a.group_by{|i|i.boss_id}
    end

end