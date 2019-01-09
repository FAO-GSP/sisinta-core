# General test configuration.

ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'
require 'minitest/pride'
# Enable spec DSL.
# Needed for controller and decorator tests.
require 'minitest/rails'
# Needed for system tests.
require 'capybara/minitest/spec'

class ActiveSupport::TestCase
  # Model initialization helpers.
  include FactoryBot::Syntax::Methods

  before :each do
    # Start a transaction (default method for ActiveRecord).
    DatabaseCleaner.start
  end

  after :each do
    # Rollback the transaction.
    DatabaseCleaner.clean
  end
end

class ActionDispatch::IntegrationTest
  # Model initialization helpers.
  include FactoryBot::Syntax::Methods
  # User sign_in, sign_out.
  include Devise::Test::IntegrationHelpers
end

module ActionDispatch::Integration
  class Session
    # Sets up current locale as default for url_helpers mimicking ApplicationController.
    def default_url_options
      { locale: I18n.locale }
    end
  end
end

# Custom helpers for use in several tests or factories.
module SisintaTestHelpers
  # Allows to fake file uploads.
  def uploaded_file(path = 'pixel.png', mime_type = 'image/png')
    Rack::Test::UploadedFile.new(Rails.root.join('test/fixtures/files', path), mime_type)
  end
  module_function :uploaded_file
end

# In Geojson tests the real host is needed instead of test.host.
class Draper::HelperProxy
  include Rails.application.routes.url_helpers

  def default_url_options
    Rails.application.config.action_mailer.default_url_options.merge locale: I18n.locale
  end
end
