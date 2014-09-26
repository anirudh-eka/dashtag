require 'pry'
require 'singleton'

class APIService
  include Singleton
  attr_reader :last_update

  def initialize
    @penultimate_update = nil
    @last_update = Time.new(1720)
  end

  def get_posts(hashtag)
    begin
      pull_posts!(hashtag)  
    rescue
      nil
    end
  end

  def pull_posts!(hashtag)
    rate_to_hit_api = ENV["API_Rate"] ? ENV["API_Rate"].to_f : 15

    if (Time.now - last_update > rate_to_hit_api)
      @last_update = Time.now

      pull_instagram_posts_and_parse(hashtag)
      pull_twitter_posts_and_parse(hashtag)
    else
      raise "Time since last pull is less than api rate limit"
    end
  end

  def pull_new_posts(hashtag)
    @penultimate_update = last_update
    get_posts(hashtag)
  end

  def did_service_update?
    @last_update > @penultimate_update
  end

  private

	def pull_instagram_posts_and_parse(hashtag)
    instagram_client_id = ENV["INSTAGRAM_CLIENT_ID"]
    response = HTTParty.get("https://api.instagram.com/v1/tags/#{hashtag}/media/recent?client_id=#{instagram_client_id}")

    GramFactory.make_grams(response.parsed_response)
	end

  def pull_twitter_posts_and_parse(hashtag)
    response = HTTParty.get("https://api.twitter.com/1.1/search/tweets.json?q=%23#{hashtag}",
    :headers => { "Authorization" => "Bearer #{twitter_bearer_token}",
      "User-Agent" => "#NAAwayDay Feed v1.0"})
    TweetFactory.make_tweets(response.parsed_response)
  end

  def twitter_bearer_token
    authorization_key = Base64.encode64(ENV["TWITTER_BEARER_CREDENTIALS"]).gsub("\n","")
    
    resp = HTTParty.post('https://api.twitter.com/oauth2/token',
      :headers => { 
        "Authorization" => "Basic #{authorization_key}",
        "User-Agent" => "Hashtag Displayer Feed v1.0",
        "Content-Type" => "application/x-www-form-urlencoded;charset=UTF-8"
        },
      body: {"grant_type" => "client_credentials"}
    )
    resp["access_token"]
  end
end
