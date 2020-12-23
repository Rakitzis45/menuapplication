class ItemsController < ApplicationController
    def new
        @item = Item.new
        @category = Category.find_by(id:params[:category_id])
        session[:last_category] = @category.id
    end

    def create
        @category = Category.find_by(id:session[:last_category])
        @item = Item.new(items_params) do |f|
            f.category_id = session[:last_category]
        end
        if @item.save
            redirect_to restaurant_menu_path(@category.restaurant)
        else
            render 'items/new'
        end
    end

    def edit
        find_item
        @category = Category.find_by(id:params[:category_id])
        session[:last_category] = @category.id
    end

    def update
        find_item
        @category = Category.find_by(id:session[:last_category])
        if @item.update(items_params).tap do |f|
            @item.category_id = @category.id 
            end
            redirect_to restaurant_menu_path(@category.restaurant)
        else
            render 'items/edit'
        end
    end

    def destroy
        find_item
        @restaurant = @item.category.restaurant
        @item.destroy
        redirect_to restaurant_menu_path(@restaurant)
    end

    private
    def items_params
        params.require(:item).permit(:name, :price, :category_id)
    end

    def find_item
        @item = Item.find_by(id:params[:id])
    end

end
