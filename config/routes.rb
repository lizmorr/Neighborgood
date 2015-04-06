Rails.application.routes.draw do
  root "neighborhoods#index"
  devise_for :users

  resources :neighborhoods do
    resources :reviews, only: [:new, :create, :edit, :update, :destroy]
  end
end
