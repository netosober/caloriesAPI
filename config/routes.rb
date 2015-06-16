Rails.application.routes.draw do
  devise_for :users
  namespace :api do
    namespace :v1 do
      resources :meals
      resources :users, only: [:create]
      match '/users' => 'users#show', :via => :get
      match '/users' => 'users#index', :via => :get
      match '/users' => 'users#update', :via => :put
      match '/users' => 'users#destroy', :via => :delete
    end
  end
end
