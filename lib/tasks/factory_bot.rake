# Custom FactoryBot tasks

namespace :factory_bot do
  # Lint all the factories. This should run before the full test suite
  desc 'Verify that all FactoryBot factories are valid'
  task lint: :environment do
    if Rails.env.test?
      # Wrap it inside a transaction as to ensure the DB stays clean
      ActiveRecord::Base.transaction do
        # FactoryBot will raise an exception if any factory fails
        FactoryBot.lint FactoryBot.factories

        # Force a rollback when every factory passes

        puts 'Success! All factories passed linting.'
        raise ActiveRecord::Rollback
      end
    else
      # Rerun forcing test environment
      system 'RAILS_ENV=test rails factory_bot:lint'
    end
  end
end
