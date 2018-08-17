Rails.application.routes.draw do
  root to: 'map#index'

  get 'map/index'

  # User management engine with sessions, passwords, registrations and
  # confirmations
  devise_for :users
end
