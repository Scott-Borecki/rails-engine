Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
      namespace :items do
        resources :find, only: [:index]
      end

      namespace :merchants do
        resources :find_all, only: [:index]
      end

      resources :items, only: [:index, :show, :create, :update, :destroy] do
        resources :merchant, only: [:index], controller: 'items/merchant'
      end

      resources :merchants, only: [:index, :show] do
        resources :items, only: [:index], controller: 'merchants/items'
      end

      namespace :revenue do
        resources :merchants, only: [:index, :show]
      end
    end
  end
end
