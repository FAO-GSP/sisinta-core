# Base controller class.

class ApplicationController < ActionController::Base
  before_action :setup_locale, :setup_global_search

  # ActiveAdmin check for a logged-in user with admin rights
  def authenticate_admin!
    authenticate_user!

    access_denied unless current_user.admin?
  end

  # Sets up current locale as default for url_helpers
  def default_url_options
    { locale: I18n.locale }
  end

  private

  # Sets up the locale for this request
  def setup_locale
    # It is safe to assign because it is restricted to available locales and a
    # default is set by routes
    I18n.locale = params[:locale]
  end

  # Prepares everything needed to search Profiles from the navigation bar
  def setup_global_search
    @global_search = Profile.search
  end

  # Used here for authentication and by ActiveAdmin when checking authorization
  def access_denied
    flash[:alert] = I18n.t 'active_admin.access_denied.message'
    redirect_to root_path
  end
end
