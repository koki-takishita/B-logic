Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root :to => 'users#index'
  resources :goals
  resources :subgoals
  resources :task
  resources :users, only: [:edit, :update, :destroy, :show]

  scope :start do
    get 'login' => 'user_sessions#new', :as => :login
    post 'login' => "user_sessions#create"
    post 'logout' => 'user_sessions#destroy', :as => :logout
    resources :users, only: [:new, :create]
  end
end
