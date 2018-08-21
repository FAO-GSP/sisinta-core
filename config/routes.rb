Rails.application.routes.draw do
  # Default map as landing page.
  root to: 'map#index'
  get 'map/index'

  # User management engine with sessions, passwords, registrations and
  # confirmations
  devise_for :users

  resources :profiles, only: [:index, :show]
end
