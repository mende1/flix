Rails.application.routes.draw do
  resources :favorites
  root 'movies#index'

  resources :movies do
    resources :reviews
  end

  resources :users
  get "signup", to: "users#new"

  resource :session, only: %i[new create destroy]
  get "sign_in", to: "sessions#new"
  delete "sign_out", to: "sessions#destroy"
end
