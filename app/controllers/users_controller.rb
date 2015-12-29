class UsersController < ApplicationController
    before_action :authenticate_user!

    def index
    end
    
    def show
        if params[:id]
            user = User.find(params[:id])
        else
            user = current_user
        end

        if user
            @articles = user.articles
        else
            redirect_to user_path
        end
    end
end
