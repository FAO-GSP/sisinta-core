# Application routes
Rails.application.routes.draw do
  # Route the whole app with an optional locale. If it's missing the controller
  # should try to get it from current user o use the default in case it's
  # missing. Only allows configured locales, the rest returns 404
  scope '(:locale)', locale: /#{I18n.available_locales.join('|')}/ do
    # Default map as landing page.
    root to: 'map#index'
    get 'map/index'

    # User management engine with sessions, passwords, registrations and
    # confirmations
    devise_for :users

    # Administration Panel
    ActiveAdmin.routes(self)

    resources :profiles, only: [:index, :show]
  end
end
