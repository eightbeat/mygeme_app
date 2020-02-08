Rails.application.routes.draw do
  root "pages#home"
  get 'pages/home', to: 'pages#home'

  resources :games

  get '/signup', to: 'users#new'
  resources :users, expect: [:new]

  get '/login', to: "sessions#new"
  post '/login', to: "sessions#create"
  delete '/logout', to: "sessions#destroy"
end
