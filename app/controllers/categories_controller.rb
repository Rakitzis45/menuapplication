class CategoriesController < ApplicationController
    before_action :require_login, only: [:new, :create, :edit, :update]

    def new
        @category = Category.new
        find_restaurant
        session[:last_restaurant] = @restaurant.id
    end

    def create
        @category = Category.new(categories_params) do |f|
            f.restaurant_id = session[:last_restaurant]
        end
        @restaurant = Restaurant.find_by(id:session[:last_restaurant])
        if @category.save
            redirect_to restaurant_menu_path(@restaurant)
        else
            render 'categories/new'
        end
    end

    def edit
        @category = Category.find_by(id:params[:format])
        find_restaurant
        if @category.restaurant.user_id == session[:user_id]
            session[:last_restaurant] = @restaurant.id
        else
            redirect_to user_myrestaurants_path(session[:user_id])
        end
    end

    def update
        find_category
        @restaurant = Restaurant.find_by(id:session[:last_restaurant])
        if @category.update(categories_params).tap do |f| 
            @category.restaurant_id = session[:last_restaurant]
            end
            redirect_to restaurant_menu_path(@restaurant)
        else
            render 'categories/edit'
        end
    end

    def destroy
        find_category
        @restaurant = @category.restaurant
        @category.destroy
        redirect_to restaurant_menu_path(@restaurant)
    end

    private
    def categories_params
        params.require(:category).permit(:name, :restaurant_id)
    end

    def find_category
        @category = Category.find_by(id:params[:id])
    end

    def find_restaurant
        @restaurant = Restaurant.find_by(id:params[:restaurant_id])
    end
end
