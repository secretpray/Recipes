=======
# README

Application Recipe https://recipes-2021.herokuapp.com/

Used gem:
* Devise
* Pundit
* FriendlyId
* Kaminari
* Active Text (InRails)
* Active Storage (InRails)
* BootStrap
* Faker
* Gravatar
* acts_as_votable
* fontawesome
* ancestry
* omniauth, 'omniauth-facebook', 'omniauth-github', omniauth-google-oauth2'
* activerecord-session_store
* Gravatar
* Ransack
* I18n
* aws-sdk-s3
* rails-social-share-button

Feature:
* Active Text
* Active Storage (Amazon S3)
* Paginate (+ BootStrap theme for Kaminari)
* Favorite (AJAX)
* Category with Ancestry
* Voted comments with acts_as_votable gem
* 5 Star Rating and Review with JS
* Tags for Recipe and tags cloud
* Recipes, Favorites, Comments counter_cache for User model
* Comments with avatar (AJAX)
* Nested Forms
* Authentication with Devise (email/username)
* Authentication with Facebook, Github omniauth and Google oauth2 (with support User attributes update)
* Avatar for User and more Devise attributes: First name, Last Name, Username (uniq), Birthday, About 
* Recipes 10+ attributes (calories, prep/cook times; serves, fat, salt, sugar, protein, fibre ....)
* Badge: Gluten-free; Vegan; Vegetarian, Easy, Kosher, Free: gluten, sugar, salt)
* Authorize with Pundit
* Localization Russin/English (+ User attribute language)
* Disappearing flash messages with toastr js
* AutoHide & close Errors/Flash message with vanila JS
* Popover with vanila JS
* Simple search
* Advanced search with ransack
* Sort recipes by Title, Cteated, Category with ransack
* User status in model (:active, :disabled, :banned);
* User online status;
* Social share button with share to Facebook fixed link; 
* Print Recipe
* Inline update counter comments (AJAX)
* Personal user page (recent users Recipe, Favorite and Comments)
* Static Page "About", "Terms", "Limits"
* Custom static page (404/422/500)
* Heroku
* SEEDS (Faker)

TODO:
* Added Replies to comments (React?)
* Action Cable (replay comment, create Recipe)
* Polymorh Trophy
* dynamic add/remove fields for Ingredients & Steps
* inline Edit Recipe
* Infinite scroll
* Search with autocomplete
* Save Recipe (+ PDF)
* Hotwire
* Follow User
* RSS feed
* Chat room
* Forum
