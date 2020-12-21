class UsersController < ApplicationController
    def new
        @user = User.new
    end

    def create
        @user = User.new(user_params)
        if @user.save
            session[:user_id] = @user.id
            redirect_to search_path
        else
            render 'users/new'
        end
    end

    def edit
        find_user
    end
    
    def update
        find_user
        if user_params[:password].blank? && user_params[:password].blank?
            params[:user].delete("password")
            params[:user].delete("password_confirmation")
            if @user.update(user_params)
                redirect_to search_path
            else
                render 'users/edit'
            end
        else
            if @user.update(user_params)
                redirect_to search_path
            else
                render 'users/edit'
            end
        end
    end

    def myrestaurants
        find_user
    end

    def destroy
        find_user
    end

    private
    def user_params
        params.require(:user).permit(:name, :email, :admin, :password, :password_confirmation)
    end

    def find_user
        @user = User.find_by(id:current_user)
    end


end
