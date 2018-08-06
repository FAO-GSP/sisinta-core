Rails.application.routes.draw do
  root to: 'devise/sessions#new'

  # User management engine with sessions, passwords, registrations and
  # confirmations
  devise_for :users
end
