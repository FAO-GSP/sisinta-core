# Base controller class.

class ApplicationController < ActionController::Base
  before_action :setup_locale, :setup_global_search
  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from CanCan::AccessDenied, with: :access_denied

  # ActiveAdmin check for a logged-in user with admin rights.
  def authenticate_admin!
    authenticate_user!

    access_denied unless current_user.admin?
  end

  # Sets up current locale as default for url_helpers.
  def self.default_url_options(options = { })
    options.merge({ locale: I18n.locale })
  end

  private

  # Sets up the locale for this request.
  def setup_locale
    # It is safe to assign because it is restricted to available locales on
    # routes configuration
    I18n.locale = params[:locale] || I18n.default_locale
  end

  # Prepares everything needed to search Profiles from the navigation bar.
  def setup_global_search
    @global_search = Profile.search
  end

  # Used here for authentication and by ActiveAdmin when checking
  # authorization. `rescue_from` passes the exception.
  def access_denied(exception = nil)
    respond_to do |format|
      format.js do
        head :forbidden
      end

      format.json do
        head :forbidden
      end

      format.html do
        message = exception.try(:message) || I18n.t('active_admin.access_denied.message')

        redirect_to localized_root_path, alert: message
      end
    end
  end

  # Extend default devise params
  def configure_permitted_parameters
    # Add `name` to registration actions
    devise_parameter_sanitizer.permit :sign_up, keys: [:name]
    devise_parameter_sanitizer.permit :account_update, keys: [:name]
  end

  # Overwrite devise defaults of redirecting to root_path on sign in/out.
  def after_sign_in_path_for(resource_or_scope)
    localized_root_path
  end
  alias_method :after_sign_out_path_for, :after_sign_in_path_for
end
