Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  resources :demo_companies
  resources :demo_stocks
  
  resources :stocks
  resources :sector_masters
  resources :indices

  # Custom Routes
  get 'countries/list', to: 'indices#get_all_countries_list'
  get 'sectors/export-report', to: 'sector_masters#export_sector_report', defaults: { format: 'csv' }
  get 'indices/export-report', to: 'indices#export_indices_report', defaults: { format: 'csv' }
  get 'stocks/export-report', to: 'stocks#export_stocks_report', defaults: { format: 'csv' }
end
