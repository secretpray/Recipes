Rails.application.routes.draw do

  get 'favorites/update'
  get 'recipes/favorites'

  devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks', registrations: 'registrations' }
  resources :users, only: :show do
    member do
      get 'recipes', to: 'users#recipes'
      get :author_info, to: 'users#author_info'
      patch 'change_status', to: 'users#change_status' # patch :change_status
    end
  end

  scope "recipes/:recipe_id" do
    resources :recipe_steps
  end
  resources :categories
  resources :tags, only: :show
  resources :recipes do
    member do
      get "to_pdf", to: "recipes#to_pdf"
    end
    resources 'reviews', only: %i[index new create]
    resources 'comments', except: %i[show index] do
      member do
        patch "upvote", to: "comments#upvote"
        patch "downvote", to: "comments#downvote"
      end
    end
  end

  get '/search', to: 'dashboards#search'
  get '/privacy', to: 'dashboards#privacy'
  get '/terms', to: 'dashboards#terms'
  get '/limits', to: 'dashboards#limits'
  match "/404", via: :all, to: "errors#not_found"
  match '/422', via: :all, to: 'errors#unprocessable_entity'
  match "/500", via: :all, to: "errors#internal_server_error"


  root to: 'dashboards#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
