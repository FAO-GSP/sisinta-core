# Application routes.

Rails.application.routes.draw do
  # Redirect to map#index with default locale as landing page.
  root to: redirect(I18n.default_locale.to_s, status: 301)

  # Route the whole app with an optional locale. If it's missing the controller
  # should try to get it from current user o use the default in case it's
  # missing. Only allows configured locales, the rest returns 404.
  scope '/:locale', locale: /#{I18n.available_locales.join('|')}/ do
    # Use this route instead of root_path to include a locale.
    root to: 'map#index', as: :localized_root

    # Maps
    get 'map/index'

    # User management engine with sessions, passwords, registrations and
    # confirmations.
    devise_for :users, controllers: {
      registrations: 'devise_override/registrations'
    }

    # Administration Panel.
    ActiveAdmin.routes(self)

    # Profiles views.
    resources :profiles, only: [:index, :show]

    # Select profiles by id.
    resource :selection, only: [:update]

    # Import data from users.
    resources :imports, only: [:new, :create] do
      collection do
        # Returns the template used for importing Profiles.
        get 'template'
      end
    end

    # Any long running operation to perform on the system.
    resources :operations, only: [:index, :show, :create] do
      collection do
        # Named routes for defined operations.
        post 'export', to: 'operations#create', defaults: { operation: { name: 'csv_export' } }
      end
    end
  end
end
