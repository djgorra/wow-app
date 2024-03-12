class UsersController < ApplicationController
    before_action :authenticate_user!
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

    private

    def user_params
      params.require(:user).permit(:username, :email, :password, :password_confirmation, :avatar)
    end
end