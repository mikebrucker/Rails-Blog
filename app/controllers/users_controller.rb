class UsersController < ApplicationController
    def index
        signed_out_signin_path
        @users = User.all
        @current_user = current_user
    end

    def new
        signed_in_users_path
        @user = User.new
    end

    def create
        user = User.create(params[:user])
        flash[:success] = "Your account was created successfully."
        redirect_to user
    end

    def show
        signed_out_signin_path
        @user = User.find(params[:id])
        @current_user = current_user
    end

    def edit
        signed_out_signin_path
        @user = User.find(params[:id])
    end

    def update
        signed_out_signin_path
        user = User.find(params[:id])
        if user.password == params[:confirm_password]
            user.update(params[:user])
            flash[:success] = "Updated User."
        else 
            flash[:error] = "Incorrect Password."
        end
        redirect_to user
    end

    def destroy
        @user = User.find(params[:id])
        if @user == current_user
            sign_out
        end
        if @user.destroy
            flash[:success] = "User deleted successfully."
        else
            flash[:error] = "There was a problem deleting the user."
        end
        redirect_to signin_path
    end
end
