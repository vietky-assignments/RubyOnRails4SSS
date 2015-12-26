class CommentsController < ApplicationController
    before_action :check_permission, :only => [:destroy]

    def create
        @article = Article.find(params[:article_id])
        @comment = Comment.create(user_id: current_user.id, article_id: @article.id, body: params[:comment][:body])
        redirect_to article_path(@article)
    end
    
    def destroy
        @comment.destroy
        redirect_to article_path(@article)
    end

    private
    def comment_params
        params.require(:comment).permit(:body)
    end
    
    def check_permission
        @article = Article.find(params[:article_id])
        @comment = @article.comments.find(params[:id])

        if @article.user_id != current_user.id && @comment.user_id != current_user.id
            flash.notice = 'You\'re not allowed to delete this comment'
            redirect_to article_path(@article) 
        end
    end
end