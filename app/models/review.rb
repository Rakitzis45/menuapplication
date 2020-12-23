class Review < ApplicationRecord
    belongs_to :user
    belongs_to :restaurant

    validates_presence_of :user_id, :restaurant_id, :service_rating, :food_rating, :post
    validates_inclusion_of :service_rating, :food_rating, :in => 0..5
end
