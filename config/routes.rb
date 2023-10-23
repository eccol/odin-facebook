Rails.application.routes.draw do
  devise_for :users

  root "posts#index"
  resources :posts
  resources :comments, only: [:new, :create, :destroy]
  post 'posts/[:id]/like', to: 'posts#like', as: 'like_post'
  resources :users, only: [:index, :show]
  resources :friend_requests, only: [:create, :update, :destroy]
end
