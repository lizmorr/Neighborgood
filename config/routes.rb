Rails.application.routes.draw do
  root "neighborhoods#index"
  devise_for :users

  resources :neighborhoods, except: :destroy do
    resources :reviews, except: :show
  end
end
