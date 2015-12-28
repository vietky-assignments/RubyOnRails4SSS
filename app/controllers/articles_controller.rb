class ArticlesController < ApplicationController
    before_action :authenticate_user!
    before_action :authorized_user, :only => [:show, :edit, :update, :destroy]
    before_action :check_permission, :only => [:update, :destroy]
    
    def index
        @articles = current_user.articles
    end

    def new
        @article = Article.new
    end

    def create
        @article = current_user.articles.build(article_params)
        if @article.save
            @article.add_tags(params[:article][:hash_tags])

            flash.alert = 'Created article successfully'
            redirect_to @article
        else
            render 'new'
        end
    end
    
    def update
        @article.description = params[:article][:description]
        @article.file_path = params[:article][:file_path]
        @article.add_tags(params[:article][:hash_tags]);

        if @article.save
            flash.alert = 'Updated article successfully'
            redirect_to @article
        else
            render 'edit'
        end
    end
    
    def destroy
        @article.destroy
        redirect_to root_path
    end

    private
    def article_params
        params.require(:article).permit(:description, :file_path)
    end
    
    def authorized_user
        @article = current_user.articles.find_by_id(params[:id])
        redirect_to root_path if @article.nil?
    end
    
    def check_permission
        if @article.user_id != current_user.id
            flash.notice = 'You\'re not allowed to delete this comment'
            redirect_to article_path(@article) 
        end
    end
end