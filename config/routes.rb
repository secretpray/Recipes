Rails.application.routes.draw do
  
  get 'favorites/update'
  get 'recipes/favorites'
  resources :recipes
  devise_for :users


  root to: 'dashboard#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
