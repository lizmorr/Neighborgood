Rails.application.routes.draw do
  root "neighborhoods#index"
  devise_for :users

  resources :neighborhoods, except: :destroy do
    resources :reviews, except: :show do
      scope module: :votes do
        resources :upvote
        resources :downvote
      end
    end
  end
end
