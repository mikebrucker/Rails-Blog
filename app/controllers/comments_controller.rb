class CommentsController < ApplicationController
    def new
        @comment = Comment.new
    end
    
    def create
        @post = Post.find(params[:comment][:post_id])
        Comment.create(comment_params)
        redirect_to request.referrer
    end
    
    def show
    end
    
    def edit
        @comment = Comment.find(params[:id])
        if @comment.user != current_user
            redirect_to posts_path
        end
    end

    def update
        comment = Comment.find(params[:id])
        comment.update(comment_params)
        redirect_to comment.post
    end

    def destroy
        @comment = Comment.find(params[:id])
        if @comment.destroy
            flash[:notice] = "Comment Deleted"
        end
        redirect_to request.referrer
    end

    private

    def comment_params
        params.require(:comment).permit(:body, :user_id, :post_id)
    end
end
