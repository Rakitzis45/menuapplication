class Restaurant < ApplicationRecord
    has_many :reviews
    has_many :restaurantcuisines
    has_many :cuisines, through: :restaurantcuisines
    has_many :categories
    has_many :items, through: :categories
    belongs_to :user

    accepts_nested_attributes_for :restaurantcuisines

    validates_presence_of :name, :phone_number, :address, :city, :state, :zipcode, :cuisine_ids, :user_id
    validates_length_of :phone_number, is: 10
    validates_length_of :zipcode, is: 5
    validates_length_of :state, is: 2

    scope :search_zipcode, -> (zipcode) {where("zipcode = ?", zipcode)}
    scope :search_state, -> (state) {where("state = ?", state)}
end
