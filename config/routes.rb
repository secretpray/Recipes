Rails.application.routes.draw do
  
  get 'favorites/update'
  get 'recipes/favorites'
  # get 'recipes/user', to: 'users#recipes'
  # get 'myrecipes', action: :recipes, controller: 'users'
  
  devise_for :users, controllers: { omniauth_callbacks: 'omniauth', registrations: 'registrations' }
  resources :users, only: [:show] do
    member do 
      get 'recipes', to: 'users#recipes'
    end
  end
  resources :categories
  resources :tags, only: [:show]
  resources :recipes do
    resources 'reviews', only: [:index, :new, :create]
    resources 'comments', only: [:create, :destroy] do 
      member do
        patch "upvote", to: "comments#upvote"
        patch "downvote", to: "comments#downvote"
      end
    end
  end

  root to: 'dashboard#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
