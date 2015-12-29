class SearchController < ApplicationController
    before_action :authenticate_user!

    def index
        if params[:search]
            @articles = Article.search(params[:search])
        else
            @articles = Article.all
        end
        @articles = @articles.paginate(:page => params[:page], :per_page => GlobalConstants::ITEMS_PER_PAGE)
    end
end
