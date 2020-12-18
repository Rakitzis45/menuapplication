class RestaurantsController < ApplicationController
    def index
        search
    end

    def show
    end

    def new
        @restaurant = Restaurant.new
    end

    def create
        @restaurant = Restaurant.create(restaurant_params) do |f|
            f.user_id = session[:user_id]
        end
    end

    def edit
    end

    def update
    end

    def destroy
    end


    private
    def search
        if params[:search].empty?
            redirect_to search_path
        end
        @restaurants = Restaurant.where(state: params[:search])
        if @restaurants.empty?
            @restaurants = Restaurant.where(zipcode: params[:search])
        end
        if @restaurants.empty?
            @restaurants = Restaurant.where(cuisine: params[:search])
        end
    end

    def restaurant_params
        params.require(:restaurant).permit(:name, :phone_number, :address, :state, :zipcode, cuisine_ids: [] )
    end

end
