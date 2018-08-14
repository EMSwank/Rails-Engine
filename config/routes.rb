Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get '/api/v1/merchants/find?', to: 'merchants#show'
      resources :merchants, only: [:index, :show]
      get '/api/v1/transactions/find?', to: 'transactions#show'
      resources :transactions, only: [:index, :show]
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
