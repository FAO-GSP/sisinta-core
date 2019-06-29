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
    resources :profiles do
      collection do
        # Optional filter as URL segment (i.e. /profiles/owned).
        get '(:filter)', to: 'profiles#index', constraints: { filter: /owned/ }, as: :filtered
      end
    end

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
        post 'export/:process', to: 'operations#create', defaults: { operation: { name: 'export' } }, as: 'export'
        # Accepts the type of R processing as parameter
        post 'r/:process', to: 'operations#create', defaults: { operation: { name: 'process_with_r' } }, as: 'r'
        # TODO Review :process need
        post 'delete', to: 'operations#create', defaults: { operation: { name: 'delete' } }
      end
    end
  end
end
