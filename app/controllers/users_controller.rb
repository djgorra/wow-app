class UsersController < ApplicationController
    before_action :authenticate_user!, except: [:battletag]
    respond_to :json 
    def show
        render :json=>current_user.as_json
    end
    
    def update
        if current_user.update(user_params)
            render :json=>current_user.as_json
        else
            render json: { errors: current_user.errors }, status: :unprocessable_entity
        end
    end

    def delete
        user = User.find(params[:id])
        user.characters.destroy_all
        user.destroy

        render json: { message: "User deleted" }, status: :ok
    end

    def battletag
        if user = User.find_by(battletag: params[:battletag])
            if params[:discord_id].present?
                user.update(discord_id: params[:discord_id])
            end
            render json: {:teams => user.teams.map{|team| {:invite_code=>team.invite_code, :name=>team.name}}}
        else
            render json: { errors: "User not found" }, status: :not_found
        end
    end

    private

    def user_params
      params.require(:user).permit(:username, :email, :password, :password_confirmation, :avatar)
    end
end