class RaidsController < ApplicationController

    def items
        raid = Raid.find(params[:id])
        render json: raid, include: [:bosses => {:include => :items}]
    end

end