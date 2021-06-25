=======
# README

Application Recipe https://recipes-2021.herokuapp.com/

Used gem:
* Devise
* Pundit
* FriendlyId
* Kaminari (> Satge_36)
* Pagy (Stage_37+)
* Active Text
* Active Storage
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
* pg_search
* I18n
* aws-sdk-s3
* rails-social-share-button
* grover
* wicked
* redcarpet
* brakeman
* standard
* letter_opener

Feature:
* Actiontext and Markdown (with preview)
* Active Storage (Amazon S3)
* Paginate (+ BootStrap theme) with Kaminari/Pagy (Stage_37+)
* Favorite (AJAX)
* Category with Ancestry
* Voted comments with acts_as_votable gem
* 5 Star Rating and Review with JS
* Tags for Recipe 
* Tags 3D cloud
* Tags aucomplete with vanila JS library: choices.js
* Recipes, Favorites, Comments counter_cache for User model
* Comments and reply with avatar (AJAX)
* Comment inline edit/update with HotWire (stage_28, later -> remove)
* Comment inline edit/update with AJAX (stage_29 +)
* Comment and Reply full AJAX create/update/delete  
* Nested Forms
* Dynamic add/remove fields for Steps
* Simple inline edit fields (Recipe title)
* A wizard to create a recipe step by step (wicked gem)
* Read more/read less (description recipes#index)
* Authentication with Devise (email/username)
* Authentication with Facebook, Github omniauth and Google oauth2 (with support User attributes update)
* Avatar for User and more Devise attributes: First name, Last Name, Username (uniq), Birthday, About 
* Avatar preview after selecting a picture in User settings
* Recipes 10+ attributes (calories, prep/cook times; serves, fat, salt, sugar, protein, fibre ....)
* Badge: Gluten-free; Vegan; Vegetarian, Easy, Kosher, Free: gluten, sugar, salt)
* Infinity scroll Recipes#index/Favorites#lists with vanila JS;
* Authorize with Pundit
* Localization Russin/English (+ User attribute language)
* Disappearing flash messages with toastr js
* AutoHide & close Errors/Flash message with vanila JS
* Popover/Tooltip with vanila JS
* Datepicker with vanila JS (flatpickr)
* Simple search
* Advanced search with ransack
* Search with autocomplete (pg_search + Stimulus JS)
* Sort recipes by Title, Cteated, Category with ransack
* Recently page viewed (last 3 page)
* User status in model (:active, :disabled, :banned)
* User online status
* Social share button (Facebook, Google, Twitter ...) -* Facebook fixed link *-
* Print Recipe
* Export Recipe to PDF (gem 'grover' + puppeteer.js)
* Inline update counter comments, favorites (AJAX)
* Autogrow text_area input (Stimulus)
* Words counter in create/edit form for Recipe title/description (Stimulus)
* Personal user page (recent users Recipe, Favorite and Comments)
* Static Page "About", "Terms", "Limits"
* Custom static page (404/422/500)
* Heroku
* SEEDS (Faker)

TODO:
* Tabs in User edit profile
* Autocomplete search in add Tags (with Selectjs)
* Sortable list of Steps
* Trophy (Polymorphic Associations)
* Doorkeeper API
* Add Replies to comments (React?)
* Add video to Method Steps 
* Action Cable (replay comment, create new Recipe)
* Follow User
* Chat room
* RSS feed
* Forum
