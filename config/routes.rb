Rails.application.routes.draw do
  root "neighborhoods#index"
  devise_for :users

  resources :neighborhoods, except: :destroy do
    resources :reviews, except: :show
  end

  resources :reviews, except: :show do
    resources :upvotes, only: [:create, :update]
    resources :downvotes, only: [:create, :update]
  end
end
