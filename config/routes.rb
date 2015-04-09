Rails.application.routes.draw do
  root "neighborhoods#index"
  devise_for :users

  namespace :admin do
    resources :neighborhoods, only: [:index, :create, :destroy]
    resources :users, only: [:edit, :update, :destroy]
  end

  resources :neighborhoods, except: [:new, :create, :destroy] do
    resources :reviews, except: [:index, :show, :new]
  end

  resources :reviews, except: :show do
    resources :upvotes, only: [:create, :update]
    resources :downvotes, only: [:create, :update]
    resources :votes, only: [:update]
  end
end
