class Category < ApplicationRecord
    has_many :items
    belongs_to :restaurant

    validates_presence_of :name
end
