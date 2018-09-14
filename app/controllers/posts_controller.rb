class PostsController < ApplicationController
    def index
        signed_out_signin_path
        @posts = Post.all
        @current_user = current_user
        @comment = Comment.new
    end

    def new
        signed_out_signin_path
        @post = Post.new
        @current_user = current_user
    end
    
    def create
        post = Post.create(post_params)
        redirect_to post
    end
    
    def show
        signed_out_signin_path
        @post = Post.find(params[:id])
        @current_user = current_user
        @comment = Comment.new
    end
    
    def edit
        signed_out_signin_path
        @post = Post.find(params[:id])
        if @post.user != current_user
            redirect_to posts_path
        end
    end

    def update
        post = Post.find(params[:id])
        post.update(post_params)
        redirect_to post
    end

    def destroy
        @post = Post.find(params[:id])
        @post.comments.destroy_all
        if @post.destroy
            flash[:success] = "Post deleted successfully."
        else
            flash[:error] = "There was a problem deleting the post."
        end
        redirect_to posts_path
    end

    def myposts
        signed_out_signin_path
        @post_number = 1
        @current_user = current_user
        @posts = Post.where(user_id: @current_user.id)
        @comment = Comment.new
    end

    private

    def post_params
        params.require(:post).permit(:title, :body, :user_id)
    end
end
