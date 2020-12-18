class ApplicationController < ActionController::Base
    private
    def current_user
        session[:user_id]
    end
end
