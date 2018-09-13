class ApplicationController < ActionController::Base
    helper_method :current_user

    def current_user
        if session[:user_id]
            User.find(session[:user_id])
        end
    end

    def signed_in_users_path
        if session[:user_id]
            redirect_to posts_path
        end
    end
   
    def signed_out_signin_path
        if !session[:user_id]
            redirect_to signin_path
        end
    end

    def sign_out
        session[:user_id] = nil
    end
end
