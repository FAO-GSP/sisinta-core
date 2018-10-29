# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative 'config/application'

Rails.application.load_tasks

if ENV['LOG_TO_STDOUT'].present?
  # Broadcast logger output both to logs and stdout for rake tasks
  Rails.logger = ActiveSupport::Logger.new Rails.root.join('log', "#{Rails.env}.log")
  # Extend with broadcast support and add a second logger for stdout
  Rails.logger.extend ActiveSupport::Logger.broadcast(ActiveSupport::Logger.new(STDOUT))
end
