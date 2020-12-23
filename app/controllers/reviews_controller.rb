class ReviewsController < ApplicationController
    
    def create
        @review = Review.new(review_params) do |f|
            f.user_id = current_user
            f.restaurant_id = session[:last_restaurant]
        end
        @restaurant = Restaurant.find_by(id:session[:last_restaurant])
        get_reviews
        find_user
        if @review.save
            redirect_to restaurant_path(@restaurant)
        else
            render 'restaurants/show'
        end
    
    end

    def destroy
        review = Review.find_by(id:params[:id])
        restaurant_id = review.restaurant.id
        review.destroy
        redirect_to restaurant_path(restaurant_id)
    end

    private
    def review_params
        params.require(:review).permit(:name, :post, :food_rating, :service_rating, :user_id, :restaurant_id)
    end
end
