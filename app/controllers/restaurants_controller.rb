class RestaurantsController < ApplicationController

    before_action :require_login, only: [:new, :create, :edit, :update]

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
        get_reviews
    end

    def new
        @restaurant = Restaurant.new
    end

    def create
        @restaurant = Restaurant.new(restaurant_params) do |f|
            f.user_id = session[:user_id]
            f.state = restaurant_params[:state].downcase
            f.city = restaurant_params[:city].downcase
        end
        if @restaurant.save
            redirect_to restaurant_path(@restaurant)
        else
            render 'restaurants/new'
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
       if @restaurant.update(restaurant_params).tap do |f|
            @restaurant.state = restaurant_params[:state].downcase
            @restaurant.city = restaurant_params[:city].downcase
            @restaurant.save
            end
            redirect_to restaurant_path(@restaurant)
        else
            render "restaurants/edit"
        end
    end

    def destroy
        find_restaurant
        @restaurant.destroy
        find_user
        redirect_to user_myrestaurants_path(@user)
    end


    private
    def search
        if params[:search].empty?
            redirect_to search_path
        end

        
        @restaurants = Restaurant.where(state: params[:search] )
        if @restaurants.empty?
            @restaurants = Restaurant.where(zipcode: params[:search])
        end
        if @restaurants.empty?
            @restaurants = Restaurant.where(cuisine: params[:search])
        end

        @restaurnts = Restaurant.search_zipcode(params[:search])
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
