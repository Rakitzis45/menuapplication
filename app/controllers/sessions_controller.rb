class SessionsController < ApplicationController
    def login
    end

    def create
        @user = User.find_by(email: params[:email])
        if @user.authenticate(params[:password])
            session[:user_id] = @user.id
            redirect_to search_path
        else
           redirect_to login_path 
        end
    end


    def success
    end
    
    def googleAuth
        @user = User.find_or_create_from_omniauth(auth)
        session[:user_id] = @user.id 
        redirect_to success_path
    end

    def destroy
        session.delete :user_id
        redirect_to search_path
    end

    private 

    def auth
        request.env["omniauth.auth"]
    end

    def user_params
        params.require(:user).permit(:email, :password)
    end
    
end
