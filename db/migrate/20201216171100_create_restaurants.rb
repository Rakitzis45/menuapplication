class CreateRestaurants < ActiveRecord::Migration[6.0]
  def change
    create_table :restaurants do |t|
      t.string :name
      t.string :address
      t.string :state
      t.integer :zipcode
      t.integer :cuisine_id
      t.integer :user_id

      t.timestamps
    end
  end
end
