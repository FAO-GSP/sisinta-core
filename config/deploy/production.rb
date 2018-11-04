set :deploy_user, ENV['DEPLOY_USER']
set :deploy_to, ENV['DEPLOY_PATH']

# Which branch to deploy, master by default
set :deploy_branch, ENV['DEPLOY_BRANCH']
set :branch, fetch(:deploy_branch, :master)

# How to provision server configuration files with capistrano-config_provider
set :config_repo_url, ENV['CONFIG_SOURCE']

# How many job workers to use
set :delayed_job_workers, 2

set :default_env, { 
  'RAILS_RELATIVE_URL_ROOT' => '/sislac',
  # Needed when seeding the database.
  'SISINTA_ADMIN_EMAIL' => ENV['SISINTA_ADMIN_EMAIL'],
  'SISINTA_ADMIN_NAME' => ENV['SISINTA_ADMIN_NAME'],
  'SISINTA_ADMIN_PASSWORD' => ENV['SISINTA_ADMIN_PASSWORD']
}

server ENV['DEPLOY_SERVER'], user: fetch(:deploy_user), roles: %w{app web db}
