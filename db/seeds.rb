Step.destroy_all if Step.any?
Ingredient.destroy_all if Ingredient.any?
Recipe.destroy_all if Recipe.any?

user1 = User.create(email: 'nemov@mail.com', password: 'secretus2021')
user2 = User.create(email: 'sss@mail.com', password: 'secretus2021')
user3 = User.create(email: 'max@mail.com', password: 'secretus2021')
user4 = User.create!(email: 'neo@mail.com', password: 'secretus2021')
user1.update(role: 'admin')
user4.update(role: 'admin')

recipe1 = Recipe.create( title: 'Chorizo & mozzarella gnocchi bake', description: 'Upgrade cheesy tomato pasta with g
nocchi, chorizo and mozzarella for a comforting bake that makes an excellent midweek meal', user_id: User.first.id )

recipe2 = Recipe.create(title: 'Coconut & squash dhansak', description: 'This quick and easy vegetarian curry is perfect 
for a healthy weeknight dinner – with butternut squash, coconut milk, lentils and spinach', user_id: User.second.id )

recipe2 = Recipe.create(title: 'Minestrone in minutes', description: 'Whip up a hearty bowl of soup in next to no time, 
perfect for a quick lunch or warming supper', user_id: User.last.id )

favorite1 = Favorite.create(recipe_id: recipe1.id, user_id: user1.id)
favorite2 = Favorite.create(recipe: recipe2, user: user2)

puts "Created #{User.count} users"
puts "Created #{Recipe.count} recipes"
puts "Created #{Favorite.count} favorites"