Rails.application.routes.draw do
  root 'movies#index'

  resources :movies do
    resources :reviews
    resources :favorites
  end

  resources :genres

  resources :users
  get "signup", to: "users#new"

  resource :session, only: %i[new create destroy]
  get "sign_in", to: "sessions#new"
  delete "sign_out", to: "sessions#destroy"
end
