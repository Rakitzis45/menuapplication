class CuisinesController < ApplicationController
    has_many :restaurant_cuisines
    has_many :restaurants, through: :restaurant
end
