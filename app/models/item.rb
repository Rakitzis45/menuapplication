class Item < ApplicationRecord
    belongs_to :category

    validates_presence_of :name, :price, :category_id
    validates_numericality_of :price, :greater_than => 0
end
