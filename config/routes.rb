Rails.application.routes.draw do
  root "neighborhoods#index"
  devise_for :users

  namespace :admin do
    resources :neighborhoods, only: [:new, :create, :destroy]
  end

  resources :neighborhoods, only: [:index, :show, :edit, :update] do
    resources :reviews, only: [:new, :create, :edit, :update, :destroy]
  end
end
