Rails.application.routes.draw do
  resources :tasks
  resources :users do
    collection do
    end
  end
  resources :sessions, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create, :show]
  root to: 'tasks#index'
end

# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html``` 
