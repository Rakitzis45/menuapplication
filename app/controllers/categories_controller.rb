class CategoriesController < ApplicationController
    before_action :require_login, only: [:new, :create, :edit, :update]

    def new
        @category = Category.new
        @restaurant = Restaurant.find_by(id:params[:restaurant_id])
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
        @restaurant = Restaurant.find_by(id:params[:restaurant_id])
    end

    def update
        @category = Category.find_by(id:params[:id])
        @restaurant = Restaurant.find_by(id:categories_params[:restaurant_id])
        if @category.update(categories_params)
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
end
