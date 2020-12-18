michael = User.create(name:"Michael", email:"michael.rakitzis@gmail.com", password:"michael", admin: true)
test_user = User.create(name:"Test", email:"test@gmail.com", password:"test")
american = Cuisine.create(name:"American")
silver_spoon = Restaurant.create(name:"Silver Spoon", address:"58-21 Junction BLVD", state:"ny", zipcode: 11373, user_id: michael.id, phone_number:"7777777777" )
restaurant_cuisine = Restaurantcuisine.create(restaurant_id: silver_spoon.id, cuisine_id: american.id)
review = Review.create(post:"This place is awesome! I'm telling all my friends and family!!!", food_rating:5, service_rating:5, user_id:test_user.id, restaurant_id:silver_spoon.id)
lunch = Category.create(name:"lunch", restaurant_id: silver_spoon.id)
burger = Item.create(name:"Signature SSD CheeseBurger", price:11.99, category_id:lunch.id)

Cuisine.create(name: "Italian")
Cuisine.create(name: "Chinese")
