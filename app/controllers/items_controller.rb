class ItemsController < ApplicationController
    def new
        @item = Item.new
    end

    def create
        
        @item = Item.new(items_params)
        category = Category.find_by(id:items_params[:category_id])
        if @item.save
            redirect_to restaurant_menu_path(category.restaurant)
        else
            render 'items/new'
        end
    end

    def edit
        find_item
    end

    def update
        find_item
        if @item.update(items_params)
            redirect_to restaurant_menu_path(@item.category.restaurant)
        else
            render 'items/edit'
        end
    end

    private
    def items_params
        params.require(:item).permit(:name, :price, :category_id)
    end

    def find_item
        @item = Item.find_by(id:params[:id])
    end

end
