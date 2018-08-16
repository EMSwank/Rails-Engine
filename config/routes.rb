Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get '/merchants/find', to: 'merchants/search#show'
      get '/merchants/find_all', to: 'merchants/search#index'
      resources :merchants, only: [:index, :show]

      get '/transactions/find', to: 'transactions/search#show'
      get '/transactions/find_all', to: 'transactions/search#index'
      resources :transactions, only: [:index, :show]

      get '/invoices/find', to: 'invoices/search#show'
      resources :invoices, only: [:index, :show]

      get '/customers/find', to: 'customers/search#show'
      get '/customers/find_all', to: 'customers/search#index'
      resources :customers, only: [:index, :show]
    end
  end
end
