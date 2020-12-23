class ReviewsController < ApplicationController
    
    def create
        @review = Review.new(review_params)
        @review.user_id = current_user
        @restaurant = @review.restaurant
        @reviews = @restaurant.reviews.all
        find_user
        if @review.save
            redirect_to restaurant_path(@review.restaurant)
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
