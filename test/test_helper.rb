# General test configuration

ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'
# Enable spec DSL
require 'minitest/spec'
require 'minitest/pride'

# To add Capybara feature tests add `gem "minitest-rails-capybara"`
# to the test group in the Gemfile and uncomment the following:
# require "minitest/rails/capybara"

class Minitest::Spec
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
