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
        special_characters = ['~', '!', '@', '#', '$', '%', '^', '&', '*', '(', ')', '-', '_', '+', '?', '<', '>']
        password_has_special_character = 0
        password_checker = 0
        params[:user][:password].each_char do |pw|
            special_characters.each do |char|
                if pw == char
                    password_has_special_character += 1
                end
            end
        end
        params[:user][:password].each_char do |pw|
            ('a'..'z').each do |a|
                if pw == a
                    password_checker += 1
                end
            end
        end
        params[:user][:password].each_char do |pw| 
            ('0'..'9').each do |n|
                if pw == n
                    password_checker += 1
                end
            end
        end
        if User.where(username: params[:user][:username]).first
            flash[:error] = "Username Already Exists."
        elsif params[:user][:username].length < 4
            flash[:error] = "Username Must Be At Least 4 Characters."
        elsif password_checker + password_has_special_character != params[:user][:password].length
            flash[:error] = "Password Includes Incorrect Characters"    
        elsif password_has_special_character == 0
            flash[:error] = "Password Must Include at Least One Special Character."    
        elsif params[:user][:password].length < 8
            flash[:error] = "Password Must Be 8 Characters or Longer."
        elsif params[:user][:password] != params[:confirm_password]
            flash[:error] = "Passwords Do Not Match"
        elsif params[:user][:password] == params[:confirm_password]
            user = User.create(user_params)
            flash[:success] = "Your Account Was Created Successfully."
            redirect_to user
            return
        end
        redirect_to new_user_path
    end

    def show
        signed_out_signin_path
        @user = User.find(params[:id])
        @current_user = current_user
        @post_number = 1
        @comment = Comment.new
    end

    def edit
        signed_out_signin_path
        @user = User.find(params[:id])
        if @user != current_user
            redirect_to "/users/#{current_user.id}"
        end
    end

    def update
        signed_out_signin_path
        special_characters = ['~', '!', '@', '#', '$', '%', '^', '&', '*', '(', ')', '-', '_', '+', '?', '<', '>']
        password_has_special_character = 0
        password_checker = 0
        params[:user][:password].each_char do |pw|
            special_characters.each do |char|
                if pw == char
                    password_has_special_character += 1
                end
            end
        end
        params[:user][:password].each_char do |pw|
            ('a'..'z').each do |a|
                if pw == a
                    password_checker += 1
                end
            end
        end
        params[:user][:password].each_char do |pw| 
            ('0'..'9').each do |n|
                if pw == n
                    password_checker += 1
                end
            end
        end
        if User.where(username: params[:user][:username]).first && User.where(username: params[:user][:username]).first != current_user
            flash[:error] = "Username Already Exists."
            redirect_to request.referrer
            return
        elsif params[:user][:username].length < 4
            flash[:error] = "Username Must Be At Least 4 Characters."
            redirect_to request.referrer
            return
        elsif password_checker + password_has_special_character != params[:user][:password].length
            flash[:error] = "Password Includes Incorrect Characters"
            redirect_to request.referrer
            return
        elsif password_has_special_character == 0
            flash[:error] = "Password Must Include at Least One Special Character."
            redirect_to request.referrer
            return
        elsif params[:user][:password].length < 8
            flash[:error] = "Password Must Be 8 Characters or Longer."
            redirect_to request.referrer
            return
        elsif params[:user][:password] != params[:confirm_password]
            flash[:error] = "Passwords Do Not Match"
            redirect_to request.referrer
            return
        end
        user = current_user
        if user.password == params[:old_password]
            user.update(user_params)
            flash[:success] = "Updated User."
        else 
            flash[:error] = "Incorrect Password."
        end
        redirect_to user
    end

    def destroy
        @user = User.find(params[:id])
        @user.posts.each do |post|
            post.comments.destroy_all
        end
        @user.comments.destroy_all
        @user.posts.destroy_all
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

    private

    def user_params
        params.require(:user).permit(:username, :email, :password)
    end
end
