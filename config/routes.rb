Rails.application.routes.draw do

  get 'inventory_items/show'
  get 'inventory_items/new'
  get 'inventory_items/create'
  get 'inventory_items/edit'
  get 'inventory_items/update'
  get 'inventory_items/destroy'
  get 'sessions/new'
  get 'sessions/create'
  get 'sessions/destroy'
  get '/login', to: 'sessions#new', as: 'login'
  get '/users/:id', to: 'users#show', as: 'user'
  get '/current_user', to: 'sessions#current_user'
  post '/logout', to: 'sessions#destroy', as: :logout
  
  resources :sales
  resources :users, only: [:index, :show, :create, :show]
  resources :sessions, only: [:create, :destroy]
  resources :inventory_items
  
  resources :inventory_items, only: [:index, :show, :new, :create, :edit, :update, :destroy] do
    resources :joins, only: [:index]
  end

 
  resources :sales do
    collection do
      get 'search_by_release_order'
    end

    member do
      post 'handle_return'
    end
  end


  resources :releases do
    resources :joins, only: [:index]
  end

  resources :joins, only: [:show, :create, :destroy]
  
  resources :inventory_items do
    member do
      patch 'update_quantity'
    end
  end
  get '/users/current_user', to: 'users#current_user'
  match '/sessions', to: 'sessions#options', via: :options
end
