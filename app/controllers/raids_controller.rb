class RaidsController < ApplicationController

    def items
        raid = Raid.find(params[:id])
        render json: raid.items
    end

end