class RestaurantsController < ApplicationController

    before_action :require_login, only: [:new, :create, :edit, :update, :destroy]

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
        session[:last_restaurant] = @restaurant.id
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
        else
            if params[:search].length == 2
                
                @restaurants = Restaurant.search_state(params[:search])
            elsif params[:search].length == 5 && Integer(params[:search])
                @restaurants = Restaurant.search_zipcode(params[:search])
            else 
                cuisine = Cuisine.find_by(name: params[:search].capitalize)
                if cuisine != nil
                    @restaurants = cuisine.restaurants
                else
                    @restaurants = nil
                end
            end



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
