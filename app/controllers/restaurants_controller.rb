class RestaurantsController < ApplicationController
    def index
        search
    end

    def menu
        find_user
        @restaurant = Restaurant.find_by(id:params[:restaurant_id])
    end

    def show
        find_restaurant
        find_user
        @review = Review.new
        @reviews = @restaurant.reviews.all
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
        find_user
        find_restaurant
        
        if @user == nil || @user.id != @restaurant.user.id
            redirect_to restaurant_path(@restaurant)
        else  @user.id == @restaurant.user.id
            render "restaurants/edit"
        end
    end

    def update
        find_restaurant
        if @restaurant.update(restaurant_params)
            redirect_to restaurant_path(@restaurant)
        else
            render '"restaurants/edit"'
        end
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
        params.require(:restaurant).permit(:name, :phone_number, :address, :city, :state, :zipcode, cuisine_ids: [] )
    end

    def find_restaurant
        @restaurant = Restaurant.find_by(id:params[:id])
    end

    def find_user 
        @user = User.find_by(id:session[:user_id])
    end


end
