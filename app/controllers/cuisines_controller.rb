class CuisinesController < ApplicationController
    has_many :restaurant_cuisines
    has_many :restaurants, through: :restaurant_cuisines
end
