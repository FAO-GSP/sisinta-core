# Base job class.

class ApplicationJob < ActiveJob::Base
  queue_as :default
end
