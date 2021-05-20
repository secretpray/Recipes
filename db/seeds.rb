# Favorite.destroy_all if Favorite.any?
# Step.destroy_all if Step.any?
# Ingredient.destroy_all if Ingredient.any?
# Recipe.destroy_all if Recipe.any?
# User.destroy_all if User.any?

user1 = User.create!(email: 'nemov@mail.com', username: 'Nemov', password: 'secretus2021')
user2 = User.create!(email: 'sss@mail.com', username: 'Sss', password: 'secretus2021')
user3 = User.create!(email: 'max@mail.com', username: 'Max', password: 'secretus2021')
user4 = User.create!(email: 'neo@mail.com', username: 'Neo', password: 'secretus2021')
user5 = User.create!(email: 'dimon@mail.com', username: 'Dimon', password: 'secretus2021')
user1.update(role: 'admin')
user5.update(role: 'moderator')
# find_or_create_by!
CATEGORY_DATA = [
    "Barbecue", "Easy barbecue", "Chicken barbecue", "Picnic recipes", "Family picnic", "Healthy picnic", "Cheap eats", "Budget pasta dinners", 
    "Cheap and healthy", "Cakes & baking", "Easy baking", "Spring baking", "Family ideas", "Kids lunch recipes", "Kids party recipes", 
    "Quick and easy", "Quick & healthy", "Speedy family feasts", "Occasions", "Afternoon tea", "Sunday lunch", "Dishes", "Burger recipes", 
    "Chicken salads", "Cocktails", "Classic cocktails", "Spring cocktails", "Healthy food", "Healthy spring", "Healthy dinners", "Vegetarian", 
    "Vegetarian lunches", "Quick vegetarian", "Vegan", "Vegan storecupboard", "Vegan baking"]

CATEGORY_DATA.each do |category|
  Category.find_or_create_by!(name: category)
end

recipe1 = Category.first.recipes.create!( title: 'Chorizo & mozzarella gnocchi bake', description: 'Upgrade cheesy tomato pasta with g
nocchi, chorizo and mozzarella for a comforting bake that makes an excellent midweek meal', user_id: User.first.id )

recipe2 = Category.second.recipes.create!(title: 'Coconut & squash dhansak', description: 'This quick and easy vegetarian curry is perfect 
for a healthy weeknight dinner – with butternut squash, coconut milk, lentils and spinach', user_id: User.second.id )

recipe3 = Category.last.recipes.create!(title: 'Minestrone in minutes', description: 'Whip up a hearty bowl of soup in next to no time, 
perfect for a quick lunch or warming supper', user_id: User.last.id )

# favorite1 = Favorite.create(recipe_id: recipe1.id, user_id: user1.id)
# favorite2 = Favorite.create(recipe: recipe2, user: user2)

# # For Pagination

# 10.times do 
#   User.create!(
#     email: Faker::Internet.free_email,
#     password: 'secretus2021'
#   )
# end

# 50.times do 
#   Recipe.create!( 
#     title: Faker::Food.dish,
#     description: Faker::Food.description,
#     user_id: User.all.sample.id
#   )
# end

# 20.times do 
#   Favorite.create!(
#     recipe_id: Recipe.all.sample.id, user_id: User.all.sample.id
#   )
# end

# 12.times do 
#   Favorite.create!(
#     recipe_id: Recipe.all.sample.id, user_id: User.find(3).id
#   )
# end
# Faker::Name.name             #=> "Tyshawn Johns Sr."
# Faker::Name.first_name       #=> "Kaci"
# Faker::Name.last_name        #=> "Ernser"
# users = User.all.select { |user| user.username == nil }
# users.each { |user| user.update(username: user.get_username) }

puts "Created #{User.count} users"
puts "Created #{Category.count} categories"
puts "Created #{Recipe.count} recipes"
puts "Created #{Favorite.count} favorites"