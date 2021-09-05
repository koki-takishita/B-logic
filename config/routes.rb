Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #root :to => 'goals#index'
  if Rails.env.development?
    require "sidekiq/web"
    mount Sidekiq::Web => "/sidekiq"
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
  root :to => 'home#top'
  get 'p_p', to: 'home#play_policies'
  get 't_of_s', to: 'home#terms_of_service'
  get 'about', to: 'home#about'
  resources :goals do
    member do
      put 'status_done'
      put 'status_run'
    end
  end
  resources :tasks do
    member do
      put 'status_done'
      put 'status_run'
      get 'select_issue'
    end
  end

  resources :issues do
    member do
      get 'select_goal'
    end
  end
  resources :users, only: [:edit, :update, :destroy, :show]

  get 'login' => 'user_sessions#new', :as => :login
  post 'login' => "user_sessions#create"
  post 'logout' => 'user_sessions#destroy', :as => :logout
  resources :users, only: [:new, :create]
  resources :contacts, only: [:new, :create]
end
