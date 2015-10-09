class SessionsController < ApplicationController
    
    def session_params
       params.require(:user).permit(:user_id, :email)
    end
   
    def new 
        @current_user ||=	session[:session_token] && User.find_by_session_token(session[:session_token])
    end
    
    def create 
        user = User.authenticate(session_params)
        if user
            session[:session_token] = user[:session_token]
            flash[:notice] = "You are logged in as #{user.user_id}"
            redirect_to movies_path
        else
            flash[:notice] = "Invalid user-id/e-mail combination!"
            redirect_to login_path
        end
        @current_user ||=	session[:session_token] && User.find_by_session_token(session[:session_token])
    end
    
    def destroy 
        session.clear
        @current_user ||=	session[:session_token] && User.find_by_session_token(session[:session_token])
        flash[:notice] = "You have logged out."
        redirect_to movies_path
    end
end
