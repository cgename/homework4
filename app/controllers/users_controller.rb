class UsersController < ApplicationController
    
    def user_params
        params.require(:user).permit(:user_id, :email)
    end
    
    def new 
        @current_user ||=	session[:session_token] && User.find_by_session_token(session[:session_token])
    
        @user = User.new
    end
    
    def create
         @current_user ||=	session[:session_token] && User.find_by_session_token(session[:session_token])
         @user = User.new(user_params)
         if User.where(:user_id => @user.user_id).blank?
            @user = User.create_user(user_params)
            flash[:notice] = "Welcome #{@user.user_id}. Your account has been created."
            redirect_to login_path
        else
            flash[:notice] = "Sorry, this user-id is taken. Try again."
            redirect_to new_user_path
        end
    end
    
    def read
        @current_user ||=	session[:session_token] && User.find_by_session_token(session[:session_token])
    end
    
    def update
        @current_user ||=	session[:session_token] && User.find_by_session_token(session[:session_token])
    end
    
    def delete
        @current_user ||=	session[:session_token] && User.find_by_session_token(session[:session_token])
    end
end
