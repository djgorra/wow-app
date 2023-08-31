class FriendsController < ApplicationController

    def index 
        render json: current_user.friendlist
    end

    def create
        user = User.find_by_battletag(params[:friend][:battletag]) || User.find_by_username(params[:friend][:battletag])
        if user
            if !current_user.friendlist.include?(user)
                friend = Friend.create(user_id: current_user.id, friend_id: user.id)
            else
                render json: {errors: "Friend already added"}
                return
            end

            render json: current_user.reload.friendlist
        else
            render json: {errors: "Friend not found"}, status: :unprocessable_entity
        end
    end

    def destroy
        friend_user = User.find_by_battletag(params[:friend][:battletag])
        friend = Friend.find_by_friend_id(friend_user.id)
        friend.destroy
        render json: current_user.friendlist
    end

end