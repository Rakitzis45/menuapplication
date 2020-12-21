class AddCitiesToRestaurants < ActiveRecord::Migration[6.0]
  def change
    add_column :restaurants, :city, :string
  end
end
