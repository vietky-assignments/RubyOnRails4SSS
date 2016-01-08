class UsersRelationshipsController < ApplicationController
    before_action :authenticate_user!

    def create
        followed_id = params[:users_relationship][:followed_id]
        @user = User.find_by_id(followed_id)
        current_user.follow!(@user)

        respond_to do |format|
            format.html { redirect_to @user }
            format.js
        end
    end

    def destroy
        followed_id = params[:users_relationship][:followed_id]
        @user = User.find_by_id(followed_id)
        current_user.unfollow!(@user)

        respond_to do |format|
            format.html { redirect_to current_user }
            format.js
        end
    end
end
