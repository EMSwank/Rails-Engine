Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get '/merchants/find', to: 'merchants/search#show'
      get '/merchants/find_all', to: 'merchants/search#index'
      get '/merchants/:id/items', to: 'merchants/items_relation#index'
      get '/merchants/:id/invoices', to: 'merchants/invoices_relation#index'
      get '/merchants/most_revenue', to: 'merchants/most_revenue#index'
      resources :merchants, only: [:index, :show]
      get '/transactions/find', to: 'transactions/search#show'
      get '/transactions/find_all', to: 'transactions/search#index'
      get '/transactions/:id/invoice', to: 'transactions/invoice_relation#show'
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
      get '/items/:id/invoice_items', to: 'items/invoice_items_relation#index'
      get '/items/:id/merchant', to: 'items/merchant_relation#show'
      resources :items, only: [:index, :show]
      get '/customers/find', to: 'customers/search#show'
      get '/customers/find_all', to: 'customers/search#index'
      get '/customers/:id/invoices', to: 'customers/invoices_relation#index'
      get '/customers/:id/transactions', to: 'customers/transactions_relation#index'
      resources :customers, only: [:index, :show]
      get '/invoice_items/find', to: 'invoice_items/search#show'
      get '/invoice_items/find_all', to: 'invoice_items/search#index'
      get '/invoice_items/:id/invoice', to: 'invoice_items/invoice_relation#show'
      get '/invoice_items/:id/item', to: 'invoice_items/item_relation#show'
      resources :invoice_items, only: [:index, :show]
    end
  end
end
