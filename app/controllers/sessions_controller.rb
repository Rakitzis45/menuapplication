class SessionsController < ApplicationController
    def login

    end

    def create
        @user = User.find_by(email: params[:email])
        if @user
            if @user.authenticate(params[:password])
                session[:user_id] = @user.id
                session.delete :error_message
                redirect_to search_path
            else
                session[:error_message] = "Login Failed"
                redirect_to login_path
            end
        else
            byebug
            session[:error_message] = "Login Failed"
            render 'sessions/login'
        end
    end


    def success
    end
    
    def googleAuth
        @user = User.find_or_create_from_omniauth(auth)
        session[:user_id] = @user.id 
        redirect_to search_path
    end

    def destroy
        session.delete :user_id
        redirect_to search_path
    end

    private 

    def auth
        request.env["omniauth.auth"]
    end

end
