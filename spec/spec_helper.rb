# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'
require 'capybara/rspec'
require 'webmock/rspec'
require 'database_cleaner'
require 'capybara/poltergeist'
require 'pry'

# require File.expand_path('../config/application', __FILE__)

WebMock.disable_net_connect!(allow_localhost: true)  # WebMock.disable_net_connect!({:allow_localhost => true})

# Capybara.javascript_driver = :selenium
Capybara.javascript_driver = :poltergeist

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

# Checks for pending migrations before tests are run.
# If you are not using ActiveRecord, you can remove this line.
ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  # ## Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr

  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = false
  # config.use_transactional_fixtures = true

  # If true, the base class of anonymous controllers will be inferred
  # automatically. This will be the default behavior in future versions of
  # rspec-rails.
  config.infer_base_class_for_anonymous_controllers = false
  config.infer_spec_type_from_file_location!

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = "random"
  config.before(:all) do
    ENV["CENSORED_WORDS"]="Big|Brother|watching"
    ENV["CENSORED_USERS"]="BadUser|dirtyuser"
    ENV["API_RATE"] = 1.to_s
    ENV["TWITTER_BEARER_CREDENTIALS"] = "asdf"
    ENV["INSTAGRAM_CLIENT_ID"] = "asd"
    ENV["HASHTAGS"] = "fda|dogs"
    ENV["TWITTER_USERS"] = "king|dogs"
    ENV["HASHTAG"] = nil
    ENV["HEADER_TITLE"] = "My Dogs"
  end

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

  config.before(:each) do
    auth_response = {"access_token"=>"ACCESS_TOKEN",
     "token_type"=>"bearer"}.to_json


    stub_request(:post, /https:\/\/#{ENV["TWITTER_BEARER_CREDENTIALS"]}@api.twitter.com\/oauth2\/token/).
      with(headers: {"content-type"=>"application/x-www-form-urlencoded;charset=UTF-8"},
        body: {"grant_type"=>"client_credentials"}).
      to_return({status: 200, body: auth_response, headers: {'content-type' => 'application/json'} })

    EnvironmentService.hashtag_array.each do |hashtag|
      stub_request(:get, "https://api.instagram.com/v1/tags/#{hashtag}/media/recent?client_id=#{ENV["INSTAGRAM_CLIENT_ID"]}").
      to_return( {:status => 200, :body => SampleInstagramResponses.instagram_response.to_json, :headers => {'content-type' => 'application/json'}})

      stub_request(:get, "https://api.twitter.com/1.1/search/tweets.json?q=%23#{hashtag}").
      with(headers: {"Authorization"=>/Bearer .+/}).
      to_return( {:status => 200, :body => SampleTweetResponses.tweet_response.to_json, :headers => {'content-type' => 'application/json'} },
        {:status => 200, :body => SampleTweetResponses.second_tweet_response.to_json, :headers => {'content-type' => 'application/json'} })
    end

    EnvironmentService.twitter_users.each do |user|
      stub_request(:get, "https://api.twitter.com/1.1/statuses/user_timeline.json?count=50&screen_name=#{user}").
      with(headers: {"Authorization"=>/Bearer .+/}).
      to_return( {:status => 200, :body => SampleTweetResponses.user_tweet_response.to_json, :headers => {'content-type' => 'application/json'} })
    end

    EnvironmentService.instagram_user_ids.each do |user_id|
      stub_request(:get, "https://api.instagram.com/v1/users/#{user_id}/media/recent/?client_id=#{EnvironmentService.instagram_client_id}").
      to_return( {:status => 200, :body => SampleInstagramResponses.user_instagram_response.to_json, :headers => {'content-type' => 'application/json'}})
    end
  end
end
