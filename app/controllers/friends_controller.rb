class FriendsController < ApplicationController

    def index 
        render json: current_user.friendlist
    end

    def create
        battletag = params[:friend][:battletag].to_s.gsub("-HASHTAG-", "#")
        user = User.find_by_battletag(battletag) || User.find_by_username(battletag)
        if user
            if !current_user.friendlist.include?(user)
                friend = Friend.create(user_id: current_user.id, friend_id: user.id)
            else
                render json: {message: "Friend already added"}
                return
            end

            render json: current_user.friendlist
        else
            render json: {message: "Friend not found"}, status: :unprocessable_entity
        end
    end

    def destroy
        friend = Friend.where(:user_id=>current_user.id, :friend_id=>params[:id]).first
        friend.destroy
        render json: current_user.friendlist
    end

end