class UsersController < ApplicationController
    def new
        @user = User.new
    end

    def create
        if user_params[:password] == user_params[:password_confirmation]
            @user = User.create(user_params)
            if @user.id
                session[:user_id] = @user.id
                redirect_to search_path
            else
                redirect_to new_user_path
            end
        else
            redirect_to new_user_path
        end
        
    end

    def edit
    end

    private
    def user_params
        params.require(:user).permit(:name, :email, :admin, :password, :password_confirmation)
    end


end
