class SessionsController < ApplicationController
    def signin
        signed_in_users_path
    end

    def create
        user = User.where(username: params[:username]).first
        
        if user.present? && user.password == params[:password]
            session[:user_id] = user.id 
            flash[:success] = "#{user.username} Logged In"
            redirect_to posts_path
        elsif !user
            flash[:alert] = "Username does not exist"
            redirect_to signin_path
        elsif user.password != params[:password]
            flash[:alert] = "Incorrect Password"
            redirect_to signin_path
        end
    end

    def destroy
        flash[:notice] = "#{current_user.username} Signed Out"
        session[:user_id] = nil
        redirect_to signin_path
    end
end
