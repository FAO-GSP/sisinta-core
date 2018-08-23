# Admin Panel configuration
ActiveAdmin.setup do |config|
  # Branding displayed on admin layout, from ApplicationHelper
  config.site_title = :app_name
  # FIXME Get favicon from Customization Gem
  # config.favicon = 'favicon.ico'

  # Generates a link to root_path from the title
  config.site_title_link = :root

  # Check for a logged-in user with admin rights
  config.authentication_method = :authenticate_admin!

  # Action to take on unauthorized access
  config.on_unauthorized_access = :access_denied

  # Defined by Devise
  config.current_user_method = :current_user

  # Use same method as Devise for logging out
  config.logout_link_path = :destroy_user_session_path
  config.logout_link_method = :delete

  # Enable Batch Actions for managing several resources at once
  config.batch_actions = true

  # Save some space on index actions
  config.localize_format = :short

  # Set the CSV builder options matching main app exporting functionality
  # TODO Research if a BOM (byte order mark) is needed for Excel
  # https://github.com/yhirano55/active_admin_csv_with_bom
  config.csv_options = { col_sep: ',', force_quotes: true }

  # Default namespace configuration
  config.namespace :admin do |admin|
    # Allowed download options
    admin.download_links = [:csv, :json]
  end
end
