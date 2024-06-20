Rails.application.routes.draw do
  get 'movies' => 'movies#index'

  root 'movies#index'
end
