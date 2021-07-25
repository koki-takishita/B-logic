Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #root :to => 'goals#index'
  if Rails.env.development?
    require "sidekiq/web"
    mount Sidekiq::Web => "/sidekiq"
  end
  root :to => 'home#top'
  resources :goals do
    member do
      put :done
    end
  end
  resources :tasks do
    put 'done', on: :member
  end

  resources :issues
  resources :users, only: [:edit, :update, :destroy, :show]

  get 'login' => 'user_sessions#new', :as => :login
  post 'login' => "user_sessions#create"
  post 'logout' => 'user_sessions#destroy', :as => :logout
  resources :users, only: [:new, :create]
end
