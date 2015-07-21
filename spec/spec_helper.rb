# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../dummy/config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'
require 'capybara/rspec'
require 'webmock/rspec'
require 'database_cleaner'
require 'capybara/poltergeist'
require 'shoulda/matchers'

module Dashtag
  require "factory_girl"
  FactoryGirl.definition_file_paths = %w(spec/factories/dashtag)
  FactoryGirl.find_definitions
end

# require File.expand_path('../config/application', __FILE__)
# Disable all out going requests so that we are only testing the app and not the external api it uses
WebMock.disable_net_connect!(allow_localhost: true)

# Capybara.javascript_driver = :selenium
Capybara.javascript_driver = :poltergeist
Capybara.default_driver = :poltergeist

Capybara.register_driver :poltergeist do |app|
  options = {
    timeout: 120
  }
  Capybara::Poltergeist::Driver.new(app, options)
end

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("../support/**/*.rb")].each { |f| require f }

# Checks for pending migrations before tests are run.
# If you are not using ActiveRecord, you can remove this line.
ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = false
  config.infer_base_class_for_anonymous_controllers = false
  config.infer_spec_type_from_file_location!
  config.order = "random"

  config.before :each do
    if Capybara.current_driver == :rack_test
      DatabaseCleaner.strategy = :transaction
    else
      DatabaseCleaner.strategy = :truncation
    end
    DatabaseCleaner.start
  end

  config.after do
    DatabaseCleaner.clean
  end
end
