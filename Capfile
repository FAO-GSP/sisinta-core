# Load DSL and set up stages.
require 'capistrano/setup'

# Include default deployment tasks.
require 'capistrano/deploy'

# Use git for versioning.
require 'capistrano/scm/git'
install_plugin Capistrano::SCM::Git

# Assets and migration tasks.
require 'capistrano/rails'
require 'capistrano/rails/collection'

# Verify rbenv is working.
require 'capistrano/rbenv'

# Verify and configure nvm.
require 'capistrano/nvm'

# Configuration provision from a private repository.
require 'capistrano/config_provider'

# Manage remote job workers.
require 'capistrano/delayed_job'

# Puma web server.
require 'capistrano/puma'
install_plugin Capistrano::Puma
install_plugin Capistrano::Puma::Nginx

# Manage cron jobs.
require 'whenever/capistrano'

# Load custom tasks from `lib/capistrano/tasks` if you have any defined.
Dir.glob('lib/capistrano/tasks/*.rake').each { |r| import r }
