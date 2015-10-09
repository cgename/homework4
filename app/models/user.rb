class User < ActiveRecord::Base
    validates :user_id, uniqueness: true
    def self.create_user(user_params)
        user_params[:session_token] = SecureRandom.base64
        @user = User.create!(user_params)
        return @user
    end
    
    def self.authenticate(session_params)
        @user = User.where(user_id: session_params[:user_id], email: session_params[:email]).present?
        if @user
            user = User.where(user_id: session_params[:user_id]).first
            return user
        else
            return false
        end
    end
end
