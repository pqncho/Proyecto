Rails.application.routes.draw do
  get 'inertia-example', to: 'inertia_example#index'

  root "articles#index"

  resources :articles do
    resources :comments, only: [:create, :destroy]
    member do
      post :toggle_like
    end
  end

  resource :session, only: [:new, :create, :destroy]
  # alias para que /login y /logout sigan andando como antes
  get  "/login",  to: "sessions#new"
  post "/login",  to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  resources :users, only: [:new, :create]
  get "/profile", to: "users#show"
  patch "/profile", to: "users#update"
  get  "/register", to: "users#new"
  post "/register", to: "users#create"

  namespace :admin do
    resources :users, only: [:index, :destroy]
  end



end