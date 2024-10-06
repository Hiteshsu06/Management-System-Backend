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
end
