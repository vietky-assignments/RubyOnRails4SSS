class SearchController < ApplicationController
    before_action :authenticate_user!

    def index
        if params[:search]
            @articles = Article.search params[:search]
        else
            @articles = Article.all
        end
    end
end
