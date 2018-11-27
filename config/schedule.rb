# Cron jobs for the application.
# TODO Extract shared path from ENV

# Use its own log.
set :output, '/srv/http/sislac/shared/log/cron.log'

# Custom job type with ENV variables set.
job_type :env_command, 'cd :path && RAILS_ENV=:environment bin/:task :output'

# Start services on boot.
every :reboot do
  # delayed_job.
  env_command 'delayed_job -n 2 restart'

  # puma.
  env_command 'puma -C /srv/http/sislac/shared/puma.rb --daemon'
end

every :day, at: '2:00 am' do
  # Clean up old operations.
  rake 'sisinta:operations:cleanup'
end
