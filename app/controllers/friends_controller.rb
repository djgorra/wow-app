class FriendsController < ApplicationController

    def index 
        render json: current_user.friends
    end

    def create
        if params[:friend][:battletag].include?("#")
            friend = Friend.create(user_id: current_user.id, friend_id: User.find_by_battletag(params[:friend][:battletag]).id)
        else
            friend = Friend.create(user_id: current_user.id, friend_id: User.find_by_username(params[:friend][:battletag]).id)
        end
        if friend
            current_user.friends << friend
            render json: current_user.friends
        else
            render json: {errors: "Friend not found"}, status: :unprocessable_entity
        end
    end

    def destroy
        friend_user = User.find_by_battletag(params[:friend][:battletag])
        friend = Friend.find_by_friend_id(friend_user.id)
        friend.destroy
        render json: current_user.friends
    end

end