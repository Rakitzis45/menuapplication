class Restaurant < ApplicationRecord
    has_many :reviews
    has_many :cuisines
    has_many :categories
    has_many :items, through: :categories
    belongs_to :user
end
