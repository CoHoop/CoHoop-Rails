require 'rubygems'
require 'spork'
require 'capybara/rspec'
require "paperclip/matchers"
require 'support/utilities'
# require 'spork/ext/ruby-debug'

Spork.prefork do
  ENV["RAILS_ENV"] ||= 'test'
  require File.expand_path("../../config/environment", __FILE__)
  require 'rspec/rails'
  require 'rspec/autorun'
  include Capybara::DSL

  # TODO: for Google Analytics, see http://www.neotericdesign.com/blog/capybara-webkit-rspec-and-javascript
  Capybara.javascript_driver = :webkit
#  Capybara.server_port = '8300'
#  Capybara.app_host = 'http://localhost:8300'
#  Capybara.javascript_driver = :selenium


  # Requires supporting ruby files with custom matchers and macros, etc,
  # in spec/support/ and its subdirectories.
  Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

  RSpec.configure do |config|
    # == Mock Framework
    #
    # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
    #
    # config.mock_with :mocha
    # config.mock_with :flexmock
    # config.mock_with :rr
    config.mock_with :rspec

    # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
    config.fixture_path = "#{::Rails.root}/spec/fixtures"

    # If you're not using ActiveRecord, or you'd prefer not to run each of your
    # examples within a transaction, remove the following line or assign false
    # instead of true.
    config.use_transactional_fixtures = false

    # Database Cleaner
    config.before(:suite) do
      DatabaseCleaner.strategy = :truncation
    end

    config.before(:each) do
      DatabaseCleaner.start
    end

    config.after(:each) do
      DatabaseCleaner.clean
    end

    # If true, the base class of anonymous controllers will be inferred
    # automatically. This will be the default behavior in future versions of
    # rspec-rails.
    config.infer_base_class_for_anonymous_controllers = false

    config.include Paperclip::Shoulda::Matchers
    config.include ValidUserRequestHelper
    config.include ModelInterface, type: :interface
    config.include Devise::TestHelpers, type: :controller
  end
end

Spork.each_run do
  # This code will be run each time you run your specs.
end
