Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get '/merchants/find', to: 'merchants/search#show'
      resources :merchants, only: [:index, :show]
      get '/api/v1/transactions/find?', to: 'transactions#show'
      resources :transactions, only: [:index, :show]
      get '/invoices/find', to: 'invoices/search#show'
      resources :invoices, only: [:index, :show]
      get '/customers/find', to: 'customers/search#show'
      resources :customers, only: [:index, :show]
    end
  end
end
