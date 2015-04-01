Rails.application.routes.draw do
  root "neighborhoods#index"
  devise_for :users

  resources :neighborhoods, only: [:index, :show, :new, :create] do
    resources :reviews, only: [:index, :new, :create, :edit, :update, :destroy]
  end

end
