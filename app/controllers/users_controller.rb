class UsersController < ApplicationController
    before_action :authenticate_user!

    def index
    end
    
    def show
        if params[:id]
            @user = User.find_by_id(params[:id])
        else
            @user = current_user
        end

        if @user
            @articles = @user.articles.paginate(:page => params[:page], :per_page => GlobalConstants::ITEMS_PER_PAGE)
        else
            redirect_to new_user_session_path
        end
    end
end
