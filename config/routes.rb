Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    passwords: 'users/passwords'
  }
  # Custom Routes
  get 'countries/list', to: 'indices#get_all_countries_list'
  get 'sectors/export-report', to: 'sector_masters#export_sector_report', defaults: { format: 'csv' }
  get 'indices/export-report', to: 'indices#export_indices_report', defaults: { format: 'csv' }
  get 'stocks/export-report', to: 'stocks#export_stocks_report', defaults: { format: 'csv' }
  get 'sectors/stocks/:id', to: 'stocks#get_all_stocks_by_sector'

  get 'users/:id', to: 'user_credentials#show'
  post 'users/filter', to: 'user_credentials#filter'
  delete 'users/:id', to: 'user_credentials#destroy'
  post 'users/role-update/:id', to: 'user_credentials#update_role'
  put 'users/update_user/:id', to: 'user_credentials#update_user'
  
  resources :demo_companies do
    collection do
      post :filter
    end
  end

  resources :demo_stocks do
    collection do
      post :filter
    end
  end

  resources :stocks do
    collection do
      post :filter
    end
  end

  resources :sector_masters do
    collection do
      post :filter
    end
  end

  resources :indices do
    collection do
      post :filter
    end
  end
end
