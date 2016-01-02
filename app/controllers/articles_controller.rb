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
        begin
            success = true
            ActiveRecord::Base.transaction do
                success &&= @article.save
                if success
                    tags = HashTag.create_tags(params[:article][:hash_tags])
                    success &&= tags.nil?
                    rels = ArticlesHashTagsRelationship.create_relationships(@article, tags)
                    success &&= rels.nil?
                else
                    raise ActiveRecord::RecordInvalid.new(@article)
                end
            end
            flash.alert = 'Created article successfully'
            redirect_to action: 'show', id: @article.id
        rescue ActiveRecord::RecordInvalid => e
            render 'new'
        end
    end
    
    def update
        begin
            success = true
            ActiveRecord::Base.transaction do
                success &&= @article.update(article_params)
                if success
                    tags = HashTag.create_tags(params[:article][:hash_tags])
                    success &&= tags.nil?
                    rels = ArticlesHashTagsRelationship.create_relationships(@article, tags)
                    sucess &&= rels.nil?
                else
                    raise ActiveRecord::RecordInvalid.new(@article)
                end
            end
            flash.alert = 'Updated article successfully'
            redirect_to action: 'show', id: @article.id
        rescue ActiveRecord::RecordInvalid => e
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