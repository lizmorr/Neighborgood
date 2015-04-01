Rails.application.routes.draw do
  root "neighborhoods#index"
  devise_for :users

  resources :neighborhoods, only: [:index, :show, :new, :create, :edit, :update]
end
