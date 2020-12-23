class ApplicationController < ActionController::Base

    private
    def current_user
        session[:user_id]
    end

    def find_user 
        @user = User.find_by(id:current_user)
    end

    def logged_in?
        !!session[:user_id]
    end

    def require_login
        unless logged_in?
            flash[:error] = "You must be logged in to access this section"
            redirect_to login_path
        end
    end
end
