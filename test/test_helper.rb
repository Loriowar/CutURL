ENV["RAILS_ENV"] ||= "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'capybara/rails'

class ActiveSupport::TestCase
  ActiveRecord::Migration.check_pending!

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  fixtures :all

  # Add more helper methods to be used by all tests here...

  # Preaty method for replace exclamation mark in condition (inverse condition in assert)
  def assert_false(condition, message)
    assert !condition, message
  end
end

class ActionDispatch::IntegrationTest
  include Capybara::DSL

  # Set port for capybara test server
  Capybara.server_host = "127.0.0.1"
  Capybara.server_port = 3010

  # Set routing options
  #[ActionController::Base, ActionDispatch::IntegrationTest].each do |klass|
  #  klass.class_eval do
  #    def default_url_options(options = {})
  #      { :host => "127.0.0.1", :port => Capybara.server_port }.merge(options)
  #    end
  #  end
  #end

  def teardown
    Capybara.reset_sessions!
    Capybara.use_default_driver
  end

  def capybara_server_url
    "http://#{Capybara.server_host}:#{Capybara.server_port}/"
  end
end

# Fix url_for method in tests
#ActionView::TestCase::TestController.instance_eval do
#  helper Rails.application.routes.url_helpers#, (append other helpers you need)
#end
#
#ActionView::TestCase::TestController.class_eval do
#  def _routes
#    Rails.application.routes
#  end
#end