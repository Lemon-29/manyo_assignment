Rails.application.routes.draw do
  resources :sessions, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create, :show]
  namespace :admin do
    resources :users
  end
  root to:'tasks#index'
  resources :tasks
end

# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html``` 
