Rails.application.routes.draw do
  devise_for :users
  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      resources :meals
      devise_for :users
    end
  end
end
