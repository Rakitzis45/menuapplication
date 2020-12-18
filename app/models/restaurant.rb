class Restaurant < ApplicationRecord
    has_many :reviews
    has_many :restaurantcuisines
    has_many :cuisines, through: :restaurantcuisines
    has_many :categories
    has_many :items, through: :categories
    belongs_to :user

    accepts_nested_attributes_for :restaurantcuisines
end
