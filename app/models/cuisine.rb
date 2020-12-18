class Cuisine < ApplicationRecord
    has_many :restaurantcuisines
    has_many :restaurants, through: :restaurantcuisines
end
