Rails.application.routes.draw do
  post '/rate' => 'rater#create', :as => 'rate'
  root "neighborhoods#index"
  devise_for :users

  namespace :admin do
    resources :neighborhoods, only: [:index, :new, :create, :destroy]
  end

  resources :neighborhoods, except: [:new, :create, :destroy] do
    resources :reviews, except: [:index, :show]
  end

  resources :reviews, except: :show do
    resources :upvotes, only: [:create, :update]
    resources :downvotes, only: [:create, :update]
    resources :votes, only: [:update]
  end
end
