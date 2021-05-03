Rails.application.routes.draw do
  
  
  get 'favorites/update'
  get 'recipes/favorites'
  
  devise_for :users
  
  resources :recipes do
    resources 'comments', only: [:create, :destroy]
  end

  root to: 'dashboard#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
