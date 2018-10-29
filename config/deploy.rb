# Config valid for this version and patch releases of Capistrano
lock "~> 3.11.0"

set :application, 'sislac'
set :repo_url, 'git@github.com:fao-gsp/sisinta-core.git'

# Capistrano defaults
set :branch, :master
set :format, :pretty
set :log_level, :debug
set :pty, false
set :keep_releases, 5

# rbenv
set :rbenv_type, :user

# rails
set :linked_dirs, %w{
  log
  tmp/pids
  tmp/cache
  tmp/sockets
  public/system
}

# Configuration files adapted to the deploy server. You need to provision these
# somehow
set :linked_files, %w{
  config/master.key
  config/database.yml
  config/sisinta.yml
  config/environments/production.rb
  config/initializers/devise.rb
}
