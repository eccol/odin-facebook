Rails.application.routes.draw do
  devise_for :users

  root "posts#index"
  resources :posts
  resources :users, only: [:index, :show]
  resources :friend_requests, only: [:create]
end
