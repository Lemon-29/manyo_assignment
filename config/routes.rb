Rails.application.routes.draw do
  resources :tasks
  resources :users
  root 'tasks#index'
  
end
