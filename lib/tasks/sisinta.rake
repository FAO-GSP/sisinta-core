# Sisinta custom tasks.

namespace :sisinta do
  namespace :operations do
    # Clean up old operations.
    desc 'Clean up operations older than a week'
    task cleanup: :environment do
      Operation.where('created_at < ?', 7.days.ago).destroy_all
    end
  end
end
