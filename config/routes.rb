Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get '/merchants/find', to: 'merchants/search#show'
      get '/merchants/find_all', to: 'merchants/search#index'
      get '/merchants/:id/items', to: 'merchants/items_relation#index'
      get '/merchants/:id/invoices', to: 'merchants/invoices_relation#index'
      resources :merchants, only: [:index, :show]
      get '/transactions/find', to: 'transactions/search#show'
      get '/transactions/find_all', to: 'transactions/search#index'
      resources :transactions, only: [:index, :show]
      get '/invoices/find', to: 'invoices/search#show'
      get '/invoices/find_all', to: 'invoices/search#index'
      get '/invoices/:id/merchant', to: 'invoices/merchant_relation#show'
      get '/invoices/:id/customer', to: 'invoices/customer_relation#show'
      get '/invoices/:id/transactions', to: 'invoices/transactions_relation#index'
      get '/invoices/:id/invoice_items', to: 'invoices/invoice_items_relation#index'
      get '/invoices/:id/items', to: 'invoices/items_relation#index'
      resources :invoices, only: [:index, :show]
      get '/items/find', to: 'items/search#show'
      get '/items/find_all', to: 'items/search#index'
      get '/customers/find', to: 'customers/search#show'
      get '/customers/find_all', to: 'customers/search#index'
      resources :customers, only: [:index, :show]
      resources :items, only: [:index, :show]
      get '/invoice_items/find', to: 'invoice_items/search#show'
      get '/invoice_items/find_all', to: 'invoice_items/search#index'
      resources :invoice_items, only: [:index, :show]
    end
  end
end
