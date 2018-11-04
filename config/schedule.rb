# Cron jobs for the application.

# Use its own log.
set :output, '/srv/http/sislac/shared/log/cron.log'

# Custom job type with ENV variables set
job_type :env_command, 'cd :path && RAILS_ENV=:environment :task'

# Start services on boot.
every :reboot do
  # delayed_job.
  env_command 'bin/delayed_job -n 2 restart'
end
