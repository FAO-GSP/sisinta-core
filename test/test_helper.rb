# General test configuration

ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'
require 'minitest/pride'
# Enable spec DSL
# Needed for controller and decorator tests
require 'minitest/rails'
# Needed for system tests
require 'capybara/minitest/spec'

# To add Capybara feature tests add `gem "minitest-rails-capybara"`
# to the test group in the Gemfile and uncomment the following:
# require "minitest/rails/capybara"

class ActiveSupport::TestCase
  # Model initialization helpers
  include FactoryBot::Syntax::Methods

  before :each do
    # Start a transaction (default method for ActiveRecord)
    DatabaseCleaner.start
  end

  after :each do
    # Rollback the transaction
    DatabaseCleaner.clean
  end
end

class ActionDispatch::IntegrationTest
  # Model initialization helpers
  include FactoryBot::Syntax::Methods
end

module ActionDispatch::Integration
  class Session
    # Sets up current locale as default for url_helpers mimicking ApplicationController
    def default_url_options
      { locale: I18n.locale }
    end
  end
end
