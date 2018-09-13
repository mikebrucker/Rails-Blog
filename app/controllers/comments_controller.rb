class CommentsController < ApplicationController
    def new
        @comment = Comment.new
    end
    
    def create
        @post = Post.find(params[:comment][:post_id])
        Comment.create(params[:comment])
        redirect_to request.referrer
    end
    
    def show
    end
    
    def edit
        @comment = Comment.find(params[:id])
        if @comment.user.id != current_user.id
            redirect_to posts_path
        end
    end

    def update
        comment = Comment.find(params[:id])
        comment.update(params[:comment])
        redirect_to posts_path
    end

    def destroy
        @comment = Comment.find(params[:id])
        if @comment.destroy
            flash[:notice] = "Comment Deleted"
        end
        redirect_to request.referrer
    end
end
