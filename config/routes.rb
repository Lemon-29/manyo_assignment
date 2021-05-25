Rails.application.routes.draw do
  resources :tasks
  resources :users
  root 'tasks#index'
  
end


# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html``` 

