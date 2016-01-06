class ArticlesController < ApplicationController
    before_action :authenticate_user!
    before_action :authorized_user, :only => [:edit, :update, :destroy]
    before_action :check_permission, :only => [:update, :destroy]

    def new
        @article = Article.new
    end

    def show
        @article = Article.find_by_id(params[:id])
    end

    def create
        @article = current_user.articles.build(article_params)
        if @article.save && @article.create_tags_and_relationships(params[:article][:hash_tags])
            flash.alert = 'Created article successfully'
            redirect_to action: 'show', id: @article.id
        else
            render 'new'
        end
    end
    
    def update
        if @article.update(article_params) && @article.create_tags_and_relationships(params[:article][:hash_tags])
            flash.alert = 'Updated article successfully'
            redirect_to action: 'show', id: @article.id
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
        params.require(:article).permit(:description, :picture)
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