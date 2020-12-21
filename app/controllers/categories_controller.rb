class CategoriesController < ApplicationController
    def new
        @category = Category.new
        
    end

    def create
        @category = Category.new(categories_params)
        @restaurant = Restaurant.find_by(id:categories_params[:restaurant_id])
        if @category.save
            redirect_to restaurant_menu_path(@restaurant)
        else
            render 'catergories/new'
        end
    end

    def edit
        @category = Category.find_by(id:params[:format])
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

    private
    def categories_params
        params.require(:category).permit(:name, :restaurant_id)
    end
end
