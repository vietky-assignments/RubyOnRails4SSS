class SearchController < ApplicationController
    before_action :authenticate_user!

    def index
        if params[:search]
            @articles = Article.search(params[:search])
                .includes('hash_tags')
                .includes('user')
        else
            @articles = Article.all
                .includes('hash_tags')
                .includes('user')
        end
        @articles = @articles.paginate(:page => params[:page], :per_page => GlobalConstants::ITEMS_PER_PAGE)
    end
end
