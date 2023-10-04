class RaidsController < ApplicationController

    def index 
        raids = Raid.all
        render json: raids
    end

    def items
        raid = Raid.find(params[:id])
        render json: raid.items.to_a.group_by{|i|i.boss_id}
    end

end