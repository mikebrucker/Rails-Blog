class PostsController < ApplicationController
    def index
        signed_out_signin_path
        @posts = Post.all
        @user = current_user
    end

    def new
        signed_out_signin_path
        @post = Post.new
        @user = current_user
    end
    
    def create
        post = Post.create(params[:post])
        redirect_to posts_path
    end
    
    def show
        signed_out_signin_path
        @post = Post.find(params[:id])
        @current_user = current_user
        @user = User.find(@post.user_id)
    end
    
    def edit
        signed_out_signin_path
        @post = Post.find(params[:id])
        @user = current_user
    end

    def update
        post = Post.find(params[:id])
        post.update(params[:post])
        redirect_to post
    end

    def destroy
        @post = Post.find(params[:id])
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
        @user = current_user
        @posts = Post.where(user_id: @user.id)
    end
end
