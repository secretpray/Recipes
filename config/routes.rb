Rails.application.routes.draw do
  
  
  get 'favorites/update'
  get 'recipes/favorites'
  
  devise_for :users
  
  resources :categories
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
