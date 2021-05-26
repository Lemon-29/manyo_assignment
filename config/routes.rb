Rails.application.routes.draw do
  resources :tasks
  resources :users
  resources :sessions, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create, :show]
  root 'tasks#index'
  collection do
  
end


# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html``` 

