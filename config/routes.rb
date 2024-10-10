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
end
